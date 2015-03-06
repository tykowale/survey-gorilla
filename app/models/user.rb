require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_many :surveys
  has_many :questions, through: :surveys
  has_many :choices, through: :questions
  has_many :answers, through: :choices

  def password
    @password ||= Password.new(self.password_hash)
  end

  def password=(value)
    @password = Password.create(value)
    self.password_hash = @password
  end

  def authenticate(pw)
    if password == pw
      self
    else
      nil
    end
  end

end
