class Poll < ApplicationRecord
  belongs_to :user
  
  #Validationd
  validates :user, presence: true
  validates :title, presence: true, length: {in: 10..180}
  validates :option_a, presence: true, length: {in: 10..130}
  validates :option_b, presence: true, length: {in: 10..130}
  
  has_many :comments
  has_many :votes
  has_many :follows
  
  has_one_attached :option_a_img
  has_one_attached :option_b_img
end
