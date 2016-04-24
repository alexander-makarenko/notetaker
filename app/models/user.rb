class User < ActiveRecord::Base
  attr_accessor :skip_password_validation

  before_save   :downcase_login, :downcase_email
  before_create :generate_auth_digest

  has_secure_password
  has_many :notes, dependent: :destroy

  LOGIN_REGEX = /\A[-\w.]*\z/i # only letters, numbers, period, hyphen, underscore
  EMAIL_REGEX = /\A[\w+-]+(\.[\w-]+)*@[a-z\d-]+(\.[a-z\d-]+)*(\.[a-z]{2,4})\z/i
  PHONE_REGEX = /\d{3}/

  validates :firstname, presence: true, length: { maximum: 30 }
  validates :lastname,  presence: true, length: { maximum: 30 }
  validates :login,     presence: true, length: { in: 5..50 },
                        uniqueness: { case_sensitive: false }
  validates :login,     format: { with: LOGIN_REGEX }, if: -> { login.present? } 
  validates :email,     presence: true, length: { maximum: 50 },
                        uniqueness: { case_sensitive: false }
  validates :email,     format: { with: EMAIL_REGEX }, if: -> { email.present? }
  validates :birthdate, presence: true
  validates :phone,     presence: true
  validates :phone,     format: { with: PHONE_REGEX }, if: -> { phone.present? }
  validates :password,  presence: true, unless: :skip_password_validation
  validates :password,  length: { in: 6..30 }, if: -> { password.present? }

  class << self
    def digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def auth_token
    @auth_token || (self.auth_token = self.class.new_token)
  end

  def auth_token=(token)
    @auth_token = token
    self.auth_digest = self.class.digest(token)
    save(validate: false) unless new_record?
    token
  end

  def name
    "#{firstname} #{lastname}"
  end

  private    

    def downcase_email
      email.downcase!
    end

    def downcase_login
      login.downcase!
    end

    def generate_auth_digest
      self.auth_digest = self.class.digest(self.class.new_token)
    end
end