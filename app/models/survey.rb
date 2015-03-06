class Survey < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :questions
  has_many :choices, through: :questions
  has_many :answers, through: :choices
  has_many :participants, through: :answers
end
