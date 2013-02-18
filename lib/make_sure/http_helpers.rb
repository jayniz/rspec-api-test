module MakeSure
  module HTTPHelpers
    class JSONHashResponse < DelegateClass(Hash)
      attr_reader :code
      def initialize(hash, code)
        @code = code
        super(hash.with_indifferent_access)
      end
    end

    class JSONArrayResponse < DelegateClass(Array)
      attr_reader :code
      def initialize(array, code)
        @code = code
        super(array)
      end
    end

    def request(verb, uri, params)
      RestClient.send(verb, uri, params: params)
    rescue => e
      e.response
    end

    classes = {
      Hash => JSONHashResponse,
      Array => JSONArrayResponse
    }

    attr_accessor :base_url

    [:get, :put, :post, :delete, :head].each do |verb|
      self.send(:define_method, verb) do |url, params = nil|
        uri = "#{base_url}#{url}"
        response = request(verb, uri, params)
        begin 
          json = JSON.parse(response)
          classes[json.class].new(json, response.code)
        rescue JSON::ParserError
          response
        end
      end
    end
  end
end
