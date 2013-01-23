class AddLabelToSnippets < ActiveRecord::Migration
  def change
  	add_column :snippets_snippets, :label, :string
  end
end
