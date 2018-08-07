class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  belongs_to :poll
  
  def as_json(opts={})
    super.merge(
      username: user.username
    )
  end
end
