class User < ActiveRecord::Base
  validates :email, uniqueness: true, presence: true
  validates :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :activated, inclusion: {
    in: [true, false]
  }
  validates :admin, inclusion: {
    in: [true, false]
  }

  after_initialize :ensure_session_token

  has_many :notes

  def self.find_by_credentials(email, password)
    user = find_by(email: email)
    return nil unless user
    user.password_matches?(password) ? user : nil
  end

  attr_reader :password

  def password=(new_password)
    @password = new_password
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def password_matches?(given_password)
    BCrypt::Password.new(password_digest).is_password?(given_password)
  end

  def reset_session_token!
    self.session_token = self.class.random_token
    save!
    session_token
  end

  def set_activation_token!
    self.activation_token = self.class.random_token
    save!
  end

  def activate!
    self.activated = true
    save!
  end

  private

  def self.random_token
    SecureRandom.urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= self.class.random_token
  end
end
