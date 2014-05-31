require 'spec_helper'

describe ContactController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'submit'" do
    it "returns http success" do
      get 'submit'
      response.should be_success
    end
  end

  describe "GET 'thank-you'" do
    it "returns http success" do
      get 'thank-you'
      response.should be_success
    end
  end

end
