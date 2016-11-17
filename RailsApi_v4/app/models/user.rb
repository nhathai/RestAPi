require 'bcrypt'
class User < ActiveRecord::Base
  validates_presence_of :firstname, :lastname, :passord, :birthday, :gender, :status
  attr_accessor :password
  before_save :encrypt_password



  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
