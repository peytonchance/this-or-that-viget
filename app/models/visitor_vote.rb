class VisitorVote < ApplicationRecord
  belongs_to :poll
  
  validates :option, presence: true
  validates :ip_address, presence: true
end
