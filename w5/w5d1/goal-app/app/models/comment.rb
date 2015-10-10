class Comment < ActiveRecord::Base
  validates :reply, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true
  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id
end