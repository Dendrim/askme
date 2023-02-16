class User < ApplicationRecord
  has_secure_password

  before_save :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nickname, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[a-zA-Z0-9_]+\z/, message: 'only allows letters, numbers and underscore' },
                       length: { maximum: 40 }
  validates :color, allow_blank: true,
                    format: { with: /\A[a-f0-9]+\z/, message: 'is not a color. Leave blank to reset color.' },
                    length: { is: 6 }

  def downcase_nickname
    nickname.downcase!
  end
end
