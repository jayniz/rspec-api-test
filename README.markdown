[![Build
Status](https://travis-ci.org/jayniz/rspec-api-test.png?branch=master)](https://travis-ci.org/jayniz/rspec-api-test)

Easy JSON API testing with RSpec
================================

If you want to test a real API to make sure it behaves as
expected via HTTP, or if you want to do some more complex
monitoring of your live API (e.g. write something, read it,
delete it, etc.), this gem helps you make your test code easier
on the eyes.

Here's what it does:

1. HTTP verbs as helper methods in your specs
2. Applies default options to all your requests (headers, etc.)
3. Assumes the response is JSON and parses it
4. Gives you the JSON response object (Array or Hash) with a
   little extra: the `code` method (so you don't have to 
   catch an exception to test for a 404).

Usage
-----

This gem adds helper methods for all HTTP verbs to your RSpec
tests, so you can just say something like:

```ruby
it "returns the correct user" do
  get("/users/123")[:name].should == "Jens Mander"
end

it "returns a 404" do 
  get("/users/0").code.should == 404
end
```

So far so good, but your current monitoring tool can also do that.
Here's an example where we create something, read an id, check
for the correct value and delete our test data:

```ruby
describe "CRUD" do
  let(:response){ post("/users", test_data.to_json) }

  it "creates a new user" do
    response.code.should == 201
  end
  
  it "returned some location header" do
    response.headers[:location].should_not be_blank
  end

  it "returned the correct id" do
    u = get("/users/#{response[:id]}")
    u[:name].should == test_data[:name]
  end

  it "deletes the user correctl" do
    delete("/users/#{response[:id]}")
    get("/users/#{response[:id]}").code.should == 404
  end
end
```

Defaults and configuration
--------------------------

Yes, you are right, there was no protocol or hostname in any
of the examples. Here's how you can configure things, for example
in `spec_helper.rb`:

```ruby
RSpecAPITest.config = {
  base_url: 'http://my-live-instance.com',
  defaults: {
    content_type: :json,
    accept: :json
  }
}
```

The `defaults` hash is passed on to RestClient and is used as
documented [here](https://github.com/archiloque/rest-client).
The parameters of our `get, put, post, delete` helpers are 
the same as `RestClient.get, RestClient.put, RestClient.post,
RestClient.delete`.

If the response couldn't be parsed as JSON, you'll just get
back the RestClient object so you can do whatever you want with
it.

Installation
------------
Just add

    gem 'rspec_api_test'

to your `Gemfile` and in `spec_helper.rb` do a 

    require 'rspec_api_test'

after you required rspec or did a `Bundler.require`.


Test
----
Git clone this repo and run `rake`.
