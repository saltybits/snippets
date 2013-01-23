class Snippets::Snippet < ActiveRecord::Base
	has_paper_trail :only => [:content], :class_name => 'Snippets::Version'
	
  attr_accessor :parent, :children
  attr_accessible :key, :label, :content

  validates :key, :presence => true, :uniqueness => true

  after_update :invalidate_cache

  def root?
    crumbs.count == 1
  end

  def leaf?
    children.empty?
  end

  def crumbs
    key.split(Snippets.config.separator).map {|string| string.titleize}
  end

  def parent_key
    if root?
      nil
    else
      key[0..key.rindex(Snippets.config.separator)-1]
    end
  end

  def base_key
    if root?
      key
    else
      key[key.rindex(Snippets.config.separator)+1..-1]
    end
  end

  def label
  	self[:label] || base_key.to_s.titleize
  end

  private
  def invalidate_cache
    Snippets.find(key).content = content if content_changed?
  end
end
