require "paper_trail" # why aren't these dependencies automatic?

require "snippets/engine"
require "snippets/configuration"

module Snippets
	class << self
		def config(&block)
			@@configuration ||= Snippets::Configuration.new

			yield @@configuration if block_given?

			@@configuration
		end

		def all
			snippets = []
			
			@@configuration.snippets.each do |key, snippet|
				snippets << snippet
			end

			snippets
		end

		def each(&block)
			all.each(&block)
		end

		def find(key)
			# Running into caching problems with live data. Skip caching for now.
			# @@configuration.snippets[key.to_s] ||= 
			Snippet.where(:key => key).first
		end

		def get(key)
			find(key).content || ''
		end

		def get!(key)
			get(key).html_safe
		end

		def set(key, content)
			snippet = find(key) || Snippet.new(:key => key)
			snippet.content = content
			snippet.save
		end

		def tree
			roots = []

			each do |snippet|
				snippet.children = []
				
				if snippet.root?
					roots << snippet
				else
					parent = find(snippet.parent_key)
					parent.children << snippet
				end
			end

			roots
		end
	end
end
