class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
  after_initialize :set_default_values
	enum user_type: [:active, :inactive, :moderator, :admin]

	def set_default_values
		#self.active = true if self.active.nil?
	end

	def self.from_omniauth(auth)
  	#where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  	where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
  	  user.provider = auth.provider
  	  user.uid = auth.uid
  	  user.name = auth.info.name
  	  user.oauth_token = auth.credentials.token
  	  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  	  user.save!
  	end
  end
end
