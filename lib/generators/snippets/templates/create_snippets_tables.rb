class CreateTables < ActiveRecord::Migration
  def self.up
    create_table "snippets_snippets", :force => true do |t|
      t.string   "key"
      t.text     "content"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
    add_index "snippets_snippets", ["key"], :name => "index_snippets_snippets_on_key", :unique => true

    create_table "snippets_versions", :force => true do |t|
      t.string   "item_type",  :null => false
      t.integer  "item_id",    :null => false
      t.string   "event",      :null => false
      t.string   "whodunnit"
      t.text     "object"
      t.datetime "created_at"
    end
    add_index "snippets_versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"
  end

  def self.down
    drop_table :snippets_snippets
    drop_table :snippets_versions
  end
end