module Snippets
	class Description < BasicObject
		attr_accessor 	:key,
						:label
						:parent,
						:children

		def initialize
			@children = []
		end
	end
end