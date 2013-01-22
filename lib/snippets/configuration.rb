module Snippets
	class Configuration
		attr_accessor 	:username, :password,
						:title,
						:url,
						:snippets,
						:separator

		def initialize
			reset
		end

		def reset
			@username = "admin"
			@password = "password"
			@title = nil
			@snippets = {}
			@separator = "/"
		end

		def sitemap(&block)
			# disable paper trail
			Snippet.paper_trail_off

			# build the basic site structure
			builder = Builder.new(self)
			builder.instance_eval &block

			# enable paper trail
			Snippet.paper_trail_on

			self
		end
	end

	class Builder# < BasicObject # triggers infinite recursion
		def initialize(configuration)
			@keys = []
			@configuration = configuration
		end

		def method_missing(key, *args, &block)
			@keys << key

			full_key = @keys.join(@configuration.separator)
			
			snippet = Snippets::Snippet.where(:key => full_key).first_or_initialize
			snippet.label = args[0]
			snippet.save!

			@configuration.snippets[snippet.key] = snippet

			instance_eval &block if block_given?

			@keys.pop
		end
	end
end