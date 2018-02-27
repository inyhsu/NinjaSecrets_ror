class User < ActiveRecord::Base
  has_secure_password
  before_validation :downcase_email
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+.)+[^@\s]+\z/

  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
