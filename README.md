# Snippets

A simple, developer focused CMS for Rails. 

## Installation

Until the gem is available use:

```
# Gemfile
gem 'snippets', :git => 'git://github.com/saltybits/snippets.git'
```

```
bundle					     # install snippets
rails g snippets:install     # generates migration that adds the required tables
bundle exec rake db:migrate  # run the migration
```

## Configuration

Configurations is done through a simple initializer.

```
# config/initializers/snippets.rb

Snippets.config do |config|
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

Go to `website.com/admin` and enter the username and password you've chosen (default is 'admin' / 'password').

Use the texteditor to edit the snippets' content.

## Embedding Snippets

```
# views/users/welcome.html.erb

<h1><%= Snippets.get('welcome/headline') %></h1>

<p><%= Snippets.get('welcome/message') %></p>

# or, use `Snippets.get!` if to allow the welcome message to be marked up

<div class="welcome-message"><%= Snippets.get!('welcome/message') %></div>
```