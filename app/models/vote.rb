class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :poll
  
  validates :option, presence: true
end
