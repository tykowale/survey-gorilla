class Answer < ActiveRecord::Base
  belongs_to :choice
  belongs_to :participant, class_name: "User", foreign_key: :user_id
end
