class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[flickr]

  validates :username, presence: true, uniqueness: true
  validates :flickr_uid, uniqueness: true, allow_nil: true


  def self.find_from_flickr_oauth(auth)
    find_by(flickr_uid: auth.uid)
  end
end
