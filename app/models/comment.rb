class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  belongs_to :poll
  
  def owned_by?(user)
    self.user == user
  end
end
