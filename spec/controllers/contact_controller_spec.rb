require 'spec_helper'

describe ContactController, :type => :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'submit'" do
    it "returns http success" do
      post 'index'
      response.should be_success
    end
  end

  describe "GET 'thank-you'" do
    it "returns http success" do
      get 'thank_you'
      response.should be_success
    end
  end

end
