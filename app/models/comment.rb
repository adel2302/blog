class Comment < ActiveRecord::Base
  validates :title, :content, :author, presence: true
  acts_as_taggable
end
