class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "pna", password: "review2014"
  protect_from_forgery
end
