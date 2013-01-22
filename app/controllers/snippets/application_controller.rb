module Snippets
  class ApplicationController < ActionController::Base
  	http_basic_authenticate_with :name => Snippets.config.username, :password => Snippets.config.password
  end
end
