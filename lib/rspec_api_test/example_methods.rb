class RSpecAPITest
  module HTTPHelpers
    module ExampleMethods

      # A hash with indifferent access and `code` and `headers
      # methods borrowed from RestClient's response
      class JSONHashResponse < DelegateClass(Hash)
        attr_reader :code, :headers
        def initialize(hash, code, headers)
          @code = code
          @headers = headers
          super(hash.with_indifferent_access)
        end
      end

      # An array with `code` and `headers methods borrowed from
      # RestClient's response
      class JSONArrayResponse < DelegateClass(Array)
        attr_reader :code, :headers
        def initialize(array, code, headers)
          @code = code
          @headers = headers
          super(array)
        end
      end

      def response
        # http://www.youtube.com/watch?v=FONN-0uoTHI
        @example.instance_variable_get('@example_group_class').response
      end

      # Dispatch a HTTP verb method to RestClient with
      # default options as in RSpecAPITest.config[:defaults]
      def request(*args)
        defaults = RSpecAPITest.config[:defaults] || {}
        opts_i = args[2].is_a?(String) ? 3 : 2
        args[opts_i] ||= {} if defaults
        args[opts_i].reverse_merge!(defaults) 
        RestClient.send(*args)
      rescue RestClient::Exception => e
        e.response
      end

      class_map = {
        Hash => JSONHashResponse,
        Array => JSONArrayResponse
      }

      # Define HTTP verb methods in RSpec examples
      [:get, :put, :post, :delete, :head].each do |verb|
        self.send(:define_method, verb) do |*args|
          out = [verb, "#{RSpecAPITest.config[:base_url]}#{args[0]}"] +  args[1..-1]
          response = request(*out)
          begin 
            json = JSON.parse(response)
            class_map[json.class].new(json, response.code, response.headers)
          rescue JSON::ParserError
            response
          end
        end
      end
    end
  end
end
