class User < ActiveRecord::Base
	has_many :activities, dependent: :destroy
	
	before_save do
		self.email.downcase!
	end
	before_create :create_remember_token

	validates :name, length: { maximum: 50 }, presence: true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
					  format: { with: VALID_EMAIL_REGEX }, 
					  uniqueness: { case_sensitive: false }
	
	has_secure_password
	validates :password, length: { minimum: 6, allow_nil: true }

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def send_password_reset
		create_password_reset_token
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end

	def activities
		Activity.where('user_id = ?', id)		
	end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_token)
		end

		def create_password_reset_token
			self.password_reset_token = User.digest(User.new_token)	
		end
end
