# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  has_secure_password

	before_validation { email.downcase! }
  before_save :create_remember_token

  validates(:name, {
    presence: true,
    length: { maximum: 30 }
  })
  validates :email,
    presence: true,
    format: { with: /\A.+@[a-z\d\-.]+\z/i },
    uniqueness: true
  validates :password,
    presence: true,
    length: { minimum: 6, maximum: 255 }
  validates :password_confirmation,
    presence: true

  private
	
      def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
      end
end
