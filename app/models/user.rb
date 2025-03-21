class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_secure_password

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
        #  :jwt_authenticatable, jwt_revocation_strategy: self

  validates	:email, presence: true, uniqueness: true
  validates :user_name, presence: true
  validates :phone_number, presence: true
  validates :address, presence: true
  
  has_many :rooms, foreign_key: :user_id
  has_one :user_info, dependent: :destroy
  has_one :upgrade, foreign_key: :user_id
  has_many :payments, foreign_key: :user_id
  has_and_belongs_to_many :subscriptions, foreign_key: :email, primary_key: :email
  
  accepts_nested_attributes_for :user_info
  # accepts_nested_attributes_for :subscription
  accepts_nested_attributes_for :upgrade, update_only: true, allow_destroy: true
  accepts_nested_attributes_for :payments

  # attr_accessor :card_holder_name, :card_number, :cvc, :billing_address, :exp_year, :exp_month, :method

  # ROLES = %w[admin member].freeze
  # validates :role, inclusion: { in: ROLES }

  # CallBacks
  after_create :update_user_verified_column_to_true
  after_create :send_pin!
  after_create :create_upgrade
  after_create :create_subscriber
  after_create :update_subscription

  def paid_plan?
    self.upgrade.plan.plan_name == "Diamon Plan"
  end

  def free_plan?
    self.upgrade.plan.plan_name == 'Free Plan'
  end

  def user_info
    super || build_user_info
  end

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

  def add_payment(payment_method, holder_name, card_number, exp_year, exp_month, cvc, billing_address)
    ActiveRecord::Base.transaction do
      Payment.create(method: payment_method, card_holder_name: holder_name, card_number: card_number, exp_year: exp_year, exp_month: exp_month, cvc: cvc, billing_address: billing_address, user_id: self[:id])
    end
  end

  def create_subscriber
    ActiveRecord::Base.transaction do
      Subscription.create(email: self.email)
    end
  end

  def update_subscription
    ActiveRecord::Base.transaction do
      sub_email = Subscription.find_by(email: self.email)
      sub_email.update(notify_when_added_to_room: self.notify_when_added_to_room)
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["phone_number", "user_name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["payments", "rooms", "upgrade", "user_info"]
  end

  private

  def create_upgrade
    Upgrade.create!(user_id: self[:id], plan_id: 1, status: "active")
  end
  
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
