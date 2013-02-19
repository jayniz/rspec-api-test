describe "Create and delete a user" do
  before(:all) do
    RSpecAPITest.config = {
     base_url: 'http://localhost:9292',
    }
  end
  @user = {foo: :bar}

  POST "/nodes/users", AS: :saved do
    headers content_type: 'application/json'
    body @user.to_json

    it "returns 201" do
      VCR.use_cassette('json hash') do
        response.code.should == 201
      end
    end

    it "something else" do
      response[:id].should == 816698
    end
  end
end
#
# POST "/nodes/users"
# HEADERS content_type: :json
# BODY my_user.to_json
# AS :create
#
# it { response.code.should == 201           }
# it { response.location.should_not be_empty }
#
#
# GET "/nodes/#{create[:id]}"
#
# it { response.code.should == 200              }
# it { response[:name].should == my_user[:name] }
#
#
# DELETE "/nodes/#{create[:id]}"
#
#
# GET "/nodes/#{create[:id]}"
#
# it { response.code.should == 404 }
#
# end
# 
