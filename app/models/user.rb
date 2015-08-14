class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
  end
	belongs_to :profile, polymorphic: true
	validates_presence_of :profile
	has_many :permissions
	has_many :activities
	accepts_nested_attributes_for :permissions
	has_many :pools, :through => :permissions
	#accepts_nested_attributes_for :pools
	has_many :messages, as: :messageable, dependent: :destroy
	accepts_nested_attributes_for :messages
	has_many :appointments, :through => :messages,:source => :messageable,
    :source_type => "Message"
	
	has_many :users, :through => :messages, :source => :messageable,
    :source_type => "User"
    has_many :institution_memberships, as: :memberable
    has_many :institutions, :through => :institution_memberships, :source => :memberable,:source_type => "User"

	before_save { self.email = email.downcase}
	validates :name, presence: true, length:{maximum: 50}
	
    def deliver_verification_instructions!
      reset_perishable_token!
      Notifier.verification_instructions(self).deliver
    end
    def verify!
      self.verified = true
      self.save
    end

	private
      
end
