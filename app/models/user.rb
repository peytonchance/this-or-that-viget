class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  
  validates :username, uniqueness: true
  
  has_many :polls
  has_many :comments
  has_many :votes
  has_many :follows
  has_many :followed_polls, through: :follows, source: :poll
  has_many :voted_polls, through: :votes, source: :poll
  
  def is_following?(poll_id)
    followed_polls.where(id: poll_id).present?
  end
  
  def get_follow(poll_id)
    follows.where(poll_id: poll_id).first
  end
  
end
