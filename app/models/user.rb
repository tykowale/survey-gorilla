require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_many :surveys
  has_many :questions, through: :surveys
  has_many :choices, through: :questions
  has_many :answers, through: :choices


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(pass)
    @entered_password = pass
    @password = Password.create(pass)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil # either invalid email or wrong password
  end

end
