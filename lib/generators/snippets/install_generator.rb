require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record/migration'

module Snippets
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    extend ActiveRecord::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)
    
    desc 'Generates a migration to add the required tables. Run `rake db:migrate` to complete the installation.'

    def create_migration_file
      migration_template 'create_snippets_tables.rb', 'db/migrate/create_snippets_tables.rb'
    end
  end
end