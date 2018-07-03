class Poll < ApplicationRecord
  belongs_to :user

  #Validationd
  validates :user, presence: true
  validates :title, presence: true, length: {in: 10..180}
  validates :option_a, presence: true, length: {in: 1..130}
  validates :option_b, presence: true, length: {in: 1..130}

  has_many :comments
  has_many :votes
  has_many :follows

  has_one_attached :option_a_img
  has_one_attached :option_b_img

  def parent_is?(child)
    self.user.id == child.id
  end

  def total_votes(option)
    votes.where(option: option).count
  end

  def fraction_of_votes(option)
    (total_votes(option).to_f / votes.count.to_f).round(2)
  end

  def option_a_img
    option_a_img.attached? ? option_a_img : option_a_url
  end

  def option_b_img
    option_b_img.attached? ? option_b_img : option_b_url
  end
end
