describe RSpecAPITest::HTTPHelpers do

  describe "HTTP requests" do
    it "set the base url for the tests" do
      defaults = {
          base_url: 'http://localhost:9292',
          defaults: { content_type: 'application/json' }
        }
      expect{
        RSpecAPITest.config = defaults
      }.to change(RSpecAPITest, :config).to(defaults)
    end

    it "return a json hash" do
      VCR.use_cassette('json hash') do
        res = post("/nodes/users", {test: :user}.to_json)
        res.code.should == 201
        res[:payload][:test].should == 'user'
      end
    end

    it "return a json array" do
      VCR.use_cassette('json array') do
        res = get("/nodes/199337/neighbours/likes")
        res.code.should == 200
        res.should have(356).items
      end
    end

    it "return a 400" do
      VCR.use_cassette('400') do
        res = get("/nodes/0")
        res.code.should == 400
      end
    end

    it "return a 404" do
      VCR.use_cassette('404') do
        res = get("/nodes/999999999")
        res.code.should == 404
      end
    end

    it "access the headers" do
      VCR.use_cassette('404') do
        res = get("/nodes/999999999")
        res.headers[:cache_control].should == "no-cache"
      end
    end
  end

  describe "Calling RestClient" do
    before(:all) do
      RSpecAPITest.config = {
          base_url: 'http://myspace.com:81',
          defaults: { content_type: 'application/soap+xml' }
        }
    end

    let(:response){ mock(response:'{"success": "true"}', code: 123) }

    it "without body and without options" do
      RestClient.should_receive(:get).
        with("http://myspace.com:81/foo", content_type: 'application/soap+xml').
        and_return(response)
      get("/foo")
    end

    it "with body but without options" do
      RestClient.should_receive(:post).
        with("http://myspace.com:81/bar", "body", content_type: 'application/soap+xml').
        and_return(response)
      post("/bar", "body")
    end

    it "without body but with options" do
      RestClient.should_receive(:get).
        with("http://myspace.com:81/foo", something: :extra, content_type: 'application/json').
        and_return(response)
      get("/foo", something: :extra, content_type: 'application/json')
    end

    it "with body and options" do
      RestClient.should_receive(:post).
        with("http://myspace.com:81/bax", "body", something: :extra, content_type: 'application/json').
        and_return(response)
      post("/bax", "body", something: :extra, content_type: 'application/json')
    end
  end
end
