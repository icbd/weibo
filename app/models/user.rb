class User < ApplicationRecord

  before_save { self.email.downcase! }

  validates :name, presence: true
  validates :email, presence: true, length: {maximum: 255}
  validates :password, presence: true, length: {minimum: 6}

  # email 合法性
  validates :email,
            format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i},
            uniqueness: {case_sensitive: false}

  has_secure_password
end
