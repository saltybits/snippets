require "paper_trail" # why aren't these dependencies automatic?

require "snippets/engine"
require "snippets/configuration"

module Snippets
	class << self
		def config
			@@configuration ||= Snippets::Configuration.new
		end

		def configure(&block)
			yield config
		end

		def all
			snippets = []
			
			config.snippets.each do |key, snippet|
				snippets << snippet
			end

			snippets
		end

		def each(&block)
			all.each(&block)
		end

		def find(key)
			config.snippets[key.to_s]
		end

		def get(key)
			find(key).content || ''
		end

		def get!(key)
			get(key).html_safe
		end

		def set(key, content)
			snippet = find(key)
			snippet.content = content
			snippet.save

			snippet
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
