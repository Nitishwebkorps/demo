class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:trackable, :validatable, :omniauthable, omniauth_providers: [:github, :google_oauth2]

  def self.from_omniauth(access_token)
    
    user = User.where(email: access_token.info.email).first       
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(
        email: access_token.info.email,
        password: Devise.friendly_token[0,20]
      )
    end
    user.name = access_token.info.email
    user.image = access_token.info.image
    user.uid = access_token.uid
    user.provider = access_token.provider
    user.save 

    user
  end


  enum :role, { normal_user: 0, admin: 1 }
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :user

  end
end
