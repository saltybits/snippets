Snippets.configure do |config|
	config.title = "Website Title"
	config.url = "http://snippets.dev"
	config.username = "admin"
	config.password = "password"

	config.sitemap do
		home do
			headline
			content
		end

		news do
			highlights
			focus do
				s1("Section I")
				s2("Section II")
			end
		end
	end
end