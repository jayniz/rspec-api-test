describe MakeSure::HTTPHelpers do

  it "returning a 404" do
  end

  it "returning a json hash" do

  end

  it "returning a json array" do
    url = "http://www.reddit.com/api/info.json"

    VCR.use_cassette('json array') do
      res = get(url, count: 1, url: '18p78h')
      res.code.should == 200
      res.should == {}
    end
  end

  it "returning non json" do
  end


end
