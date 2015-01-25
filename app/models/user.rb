class User < ActiveRecord::Base
	belongs_to :profile, polymorphic: true
	has_many :permissions
	accepts_nested_attributes_for :permissions
	has_many :pools, :through => :permissions
	#accepts_nested_attributes_for :pools
	has_many :messages, as: :messageable, dependent: :destroy
	accepts_nested_attributes_for :messages
	has_many :appointments, :through => :messages,:source => :messageable,
    :source_type => "Message"
	
	has_many :users, :through => :messages, :source => :messageable,
    :source_type => "User"

	before_save { self.email = email.downcase}
	before_create :create_remember_token
	validates :name, presence: true, length:{maximum: 50}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, 
		uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6, maximum: 50 }
	

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
