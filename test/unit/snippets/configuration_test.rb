require 'test_helper'

module Snippets
  class ConfigurationTest < ActiveSupport::TestCase
  	def setup
  		Snippets.config.reset
  		Snippet.destroy_all
  	end

    test "title can be set" do
    	Snippets.configure do |config|
    		config.title = "Test Title"
    	end

    	assert Snippets.config.title == "Test Title"
	end

	test "title can be set inline" do
		Snippets.config.title = "New Title"

		assert Snippets.config.title == "New Title"
	end

	test "snippets can be defined" do
		Snippets.configure do |config|
			config.sitemap do
				home
			end
		end

		assert_not_nil Snippets.find(:home)
	end

	test "snippets can override the default label" do
		Snippets.configure do |config|
			config.sitemap do
				home("Home Page")
			end
		end

		assert Snippets.find(:home).label == "Home Page"
	end

	test "snippets can be nested" do
		Snippets.configure do |config|
			config.sitemap do
				home do
					header do
						title
						image
					end

					footer do
						copyright
					end
				end
			end
		end
		
		assert Snippets.find("home/header/title").key == "home/header/title"
		assert Snippets.find("home/footer/copyright").key == "home/footer/copyright"
	end
  end
end
