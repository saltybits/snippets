require 'test_helper'

module Snippets
  class SnippetTest < ActiveSupport::TestCase
    def setup
        Snippet.destroy_all
        Snippets.config.reset
    end

    test "#find returns the Snippet itself" do
        Snippets.configure do |config|
            config.sitemap do
                home
            end
        end

    	assert_instance_of Snippet, Snippets.find(:home)
    end

    test "#get returns the content" do
        Snippets.configure do |config|
            config.sitemap do
                home
            end
        end

        Snippets.set(:home, "<p>Testing</p>")

        content = Snippets.get(:home)

    	assert content == "<p>Testing</p>"
        assert !content.html_safe?
    end

    test "#get! returns the html_safe version of content" do
        Snippets.configure do |config|
            config.sitemap do
                home
            end
        end

        Snippets.set(:home, "<p>Testing</p>")

        assert Snippets.get!(:home).html_safe?
    end
  end
end
