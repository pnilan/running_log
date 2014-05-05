class User < ActiveRecord::Base
	has_many :activities
	
	before_save do
		self.username.downcase!
		self.email.downcase!
	end

	before_create :create_remember_token

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

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
