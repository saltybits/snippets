require 'test_helper'

module Snippets
  class SnippetTest < ActiveSupport::TestCase
    def setup
      Snippets.config.reset
      Snippet.destroy_all
    end

  	test "snippets must have key" do
  		snippet = Snippet.new
  		snippet.save

  		assert snippet.errors.count == 1
  	end

    test "snippets can be found by key" do
    	snippet = Snippet.new(:key => "home", :content => "Testing")
      snippet.save!

    	assert Snippets.find(:home).content == "Testing"
    end

    test "default label provided" do
    	assert Snippet.new(:key => "test_key").label == "Test Key"
    end

    test "custom label can be given" do
    	assert Snippet.new(:key => "test_key", :label => "Test").label == "Test"
    end
  end
end
