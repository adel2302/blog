class Comment < ActiveRecord::Base
  validates :content, :author, presence: true
  acts_as_taggable
end
