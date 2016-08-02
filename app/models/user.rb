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


  # 类方法, 获得string的BCrypt摘要
  def User.Digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
