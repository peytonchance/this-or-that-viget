class Poll < ApplicationRecord
  belongs_to :user
  attr_accessor :expire_days
  attr_accessor :expire_hours
  attr_accessor :expire_mins
  attr_accessor :expire
  
  include ActionView::Helpers::DateHelper

  #Validationd
  validates :user, presence: true
  validates :title, presence: true, length: {in: 10..45}
  validates :option_a, presence: true, length: {in: 1..25}
  validates :option_b, presence: true, length: {in: 1..25}
  validate :both_image_options

  has_many :comments
  has_many :votes
  has_many :follows

  has_one_attached :option_a_img
  has_one_attached :option_b_img
  
  scope :recent, -> { all.order(created_at: :desc) }
  scope :is_expired, -> { where("expiry_time < ? AND expired = false", DateTime.now) }
  scope :popular, -> {left_outer_joins(:votes).where(expired: false).group("polls.id").select("polls.*, COUNT(votes.option) AS votes_count").order("votes_count DESC")}
  
  def expire=(input)
    days = input[:days].to_i
    hours = input[:hours].to_i
    mins = input[:mins].to_i
    
    self.expiry_time = Time.now + days.day + hours.hour + mins.minutes
  end
  
  def owns_poll?(user)
    self.user == user
  end
  
  def comment_count
    comments.count
  end
  
  def vote_count
    votes.count
  end
  
  def both_image_options
    if (option_a_img.attached? and option_a_url.present?) or (option_b_img.attached? and option_b_url.present?)
      errors.add(:base, "Cannot have both a file attached and an image link. Please choose one option")
    end
  end

  def parent_is?(child)
    self.user.id == child.id
  end

  def total_votes(option)
    votes.where(option: option).count
  end

  def fraction_of_votes(option)
    (total_votes(option).to_f / votes.count.to_f).round(2)
  end

  def get_option_a_img
    @image_a ||= option_a_img.attached? ? get_url(option_a_img) : option_a_url
  end

  def get_option_b_img
    @image_b ||= option_b_img.attached? ? get_url(option_b_img) : option_b_url
  end
  
  def get_url(image)
    @url = Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
  end
  
  def time_left
    (distance_of_time_in_words(DateTime.now, expiry_time).capitalize).gsub("About ", "")
  end
end
