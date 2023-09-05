class User < ApplicationRecord
  has_one :profile
  has_many :applies
  has_many :jobs
  has_secure_password

  validates :name, :email, :password_digest, :contact, :type, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "email is not valid"}
  validates :password_digest, length: { minimum: 8 }
  validates :contact, length: { is: 10 }, uniqueness: true
end
