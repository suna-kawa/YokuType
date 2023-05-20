class User < ApplicationRecord
  has_one_attached :avatar

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :age
  belongs_to_active_hash :gender
  belongs_to_active_hash :job

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:twitter2]

  def thumbnail
    avatar.variant(resize: '300x300').processed
  end

  def self.find_for_oauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)

    user ||= User.create!(
      uid: auth.uid,
      provider: auth.provider,
      username: auth[:info][:nickname],
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20],
      confirmed_at: Time.now.utc
    )
    user
  end

  def self.dummy_email(auth)
    "#{Time.now.strftime('%Y%m%d%H%M%S').to_i}-#{auth.uid}-#{auth.provider}@example.com"
  end
end
