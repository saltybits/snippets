require 'test_helper'

module Snippets
  class SnippetTest < ActiveSupport::TestCase
    def setup
        Snippets.config.reset
        Snippet.destroy_all
    end
    
    test "#find returns the Snippet itself" do
    	Snippet.create(:key => :home, :content => "Testing")
    	assert_instance_of Snippet, Snippets.find(:home)
    end

    test "#set assigns the given content" do
        Snippets.set(:home, "Home content")
        assert Snippets.get(:home) == "Home content"
    end

    test "#set returns true / false" do
        assert Snippets.set(:home, "Home content") == true
    end

    test "#get returns unescaped the Snippet content" do
    	Snippets.set(:home, "<p>Testing</p>")
    	assert Snippets.get(:home) == "<p>Testing</p>"
    end
  end
end
