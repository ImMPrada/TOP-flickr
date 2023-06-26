class User < ApplicationRecord
  before_validation :set_avatar_url, on: :create

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[flickr]

  validates :username, presence: true, uniqueness: true
  validates :flickr_uid, uniqueness: true, allow_nil: true
  validates :avatar_url, presence: true

  def self.find_from_flickr_oauth(auth)
    find_by(flickr_uid: auth.uid)
  end

  def add_flickr(auth)
    self.flickr_uid = auth.uid
    self.flickr_username = auth.info.nickname
    raise ActiveRecord::RecordInvalid unless valid?

    save!
  end

  def set_avatar_url
    self.avatar_url = "https://api.dicebear.com/6.x/bottts/svg?seed=#{username}"
  end
end
