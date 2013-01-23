# Snippets

A simple, developer focused CMS for Rails. 

## Installation

Use the github repo until the gem is available.

```
# Gemfile
gem 'snippets', :git => 'git://github.com/saltybits/snippets.git'
```

To finish the installation make sure to run the following:

```
bundle					     # install snippets
rails g snippets:install     # generates migration that adds the required tables
bundle exec rake db:migrate  # run the migration
```

## Configuration

Configurations is done through a simple initializer.

```
# config/initializers/snippets.rb

Snippets.configure do |config|
	config.title = "Website Title"
	config.url = "http://snippets.dev"
	config.username = "admin"
	config.password = "password"

	config.sitemap do
		welcome do
			headline
			message
		end

		...
	end
end
```

Make sure to mount the Snippets engine!

```
# config/routes.rb

Rails.application.routes.draw do
  mount Snippets::Engine => '/admin'
end
```

## Editting Snippets

Go to `website.com/admin` and enter the username and password you've chosen (default is `admin` / `password`).

## Embedding Snippets

```
# views/users/welcome.html.erb

<h1><%= Snippets.get('welcome/headline') %></h1>
<p><%= Snippets.get('welcome/message') %></p>
```

You have a couple options if you want to allow snippets to contain html:

```
# using get!
<%= Snippets.get!('welcome/message') %> # equivalent to Snippets.get(...).html_safe

# using raw
<%= raw Snippets.get('welcome/message') %>
```

## Notes

Snippets was deliberately designed to not allow new Snippets to be defined at runtime.  To add / remove snippets
you must update the initializer and restart the server.

### Heroku Users

Make sure to add the following to `application.rb` or you're going to run into problems.  This is due to the
initializer interacting with the database during the assets precompilation stage.

```
# application.rb
config.assets.initialize_on_precompile = false
```