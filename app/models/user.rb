class User < ApplicationRecord
  has_one_attached :avatar
  before_create :default_avatar

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture, optional: true
  belongs_to_active_hash :age, optional: true
  belongs_to_active_hash :gender, optional: true
  belongs_to_active_hash :job, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:twitter2]

  def thumbnail
    avatar.variant(resize: '100x100').processed
  end

  def default_avatar
    if !avatar.attached?
      avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'noimage.png')),
                    filename: 'default-avatar.png', content_type: 'image/png')
    end
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
