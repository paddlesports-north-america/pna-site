require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "redirects to admin root" do
      get 'index'
      response.should redirect_to admin_root_path
    end
  end

end
