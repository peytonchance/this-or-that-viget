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
end
