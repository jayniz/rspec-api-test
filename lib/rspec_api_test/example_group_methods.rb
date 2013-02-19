class RSpecAPITest
  class Requester
    include RSpecAPITest::HTTPHelpers::ExampleMethods

    def initialize(verb, url)
      @verb = verb
      @url = url
    end

    def body(body)
      raise "Can't set body, request already sent" if @response
      @body = body
    end

    def headers(headers)
      raise "Can't set headers, request already sent" if @response
      @headers = headers
    end

    def response()
      return @response if @response
      @response = self.send(@verb, @url, @body, @headers)
    end
  end
end

class RSpecAPITest
  module HTTPHelpers
    module ExampleGroupMethods

      def POST(url, params, &block)
        @request = RSpecAPITest::Requester.new(:post, url)
        if params[:AS]
          @stored ||= {}
          @stored[params[:AS]] = @request
        end
        describe "POST #{url}" do
          block.call
        end
      end

      def dispatch(*args)
        return "No request started" unless @request
        @request.send(*args)
      end

      def body(object);    self.dispatch(:body, object);    end
      def headers(object); self.dispatch(:headers, object); end

      def response
        @request.response
      end
    end
  end
end
