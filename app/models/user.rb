class User < ActiveRecord::Base
	has_many :activities
	
	before_save do
		self.username.downcase!
		self.email.downcase!
	end

	VALID_USERNAME_REGEX = /\A[a-z0-9_-]+\z/i
	validates :username, presence: true, 
						 uniqueness: { case_sensitive: false }, 
						 length: {maximum: 16}, 
						 format: { with: VALID_USERNAME_REGEX }

	validates :name, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
					  format: { with: VALID_EMAIL_REGEX }, 
					  uniqueness: { case_sensitive: false }
	
	has_secure_password
	validates :password, length: { minimum: 6 }
end
