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

    test "changes to the content are picked up immediately" do
        Snippets.config do |config|
            config.sitemap do
                home
            end
        end

        Snippets.set(:home, "456")

        assert Snippets.get(:home) == "456"
    end

    test "#get returns the content" do
    	Snippets.set(:home, "<p>Testing</p>")

        content = Snippets.get(:home)

    	assert content == "<p>Testing</p>"
        assert !content.html_safe?
    end

    test "#get! returns the html_safe version of content" do
        Snippets.set(:home, "<p>Testing</p>")

        assert Snippets.get!(:home).html_safe?
    end
  end
end
