class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :avatar, AvatarUploader
  attr_accessor :pin_0, :pin_1, :pin_2, :pin_3

  # enum role: %i[member admin]
  enum role: {
    member: 0,
    admin: 1
  }
  
  after_initialize :set_default_role, :if => :new_record?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates	:email, presence: true, uniqueness: true
  
  has_many :rooms, foreign_key: :user_id

  # ROLES = %w[admin member].freeze
  # validates :role, inclusion: { in: ROLES }

  # CallBacks
  after_create :update_user_verified_column_to_true
  after_create :send_pin!

  def set_default_role
    self.role ||= :user
  end

  # Method to update the user's email verification status to true
  def update_user_verified_column_to_true
    UpdateUserJob.perform_now(self)
  end

  # Method to reset the PIN for email verification
  def reset_pin!
    update_column(:pin, rand(1000..9999))
  end

  # Method to unverify the user's email
  def unverify!
    update_column(:verified, false)
  end

  # Method to send the PIN for email verification
  def send_pin!
    reset_pin!
    unverify!
    # Perform the job to send the PIN
    SendPinJob.perform_now(self)
  end

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '150*150!').processed
    else
      '/default_profile.jpg'
    end
  end

  private
  
  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_profile.jpg'
          )
        ),
        filename: 'default_profile.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
