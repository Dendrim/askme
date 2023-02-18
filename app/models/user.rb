class User < ApplicationRecord
  has_secure_password

  before_validation :downcase_nickname, :downcase_email

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nickname, presence: true,
                       format: { with: /\A[a-zA-Z0-9_]+\z/ },
                       length: { maximum: 40 }
  validates :color, allow_blank: true,
                    format: { with: /\A#[[:xdigit:]]{6}\z/ }

  def self.default_navbar_color
    "#370617"
  end

  private

  def downcase_email
    email.downcase!
  end

  def downcase_nickname
    nickname.downcase!
  end
end
