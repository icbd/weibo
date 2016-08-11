class User < ApplicationRecord

  has_secure_password
  # 存取器, 与 TableColumn 没有必然映射
  attr_accessor(:remember_token, :activation_token)

  before_save { self.email.downcase! }
  before_create :create_activation_digest

  validates :name, presence: true
  validates :email, presence: true, length: {maximum: 255}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  # email 合法性
  validates :email,
            format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i},
            uniqueness: {case_sensitive: false}


  # 类方法, 获得string的BCrypt摘要
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  # 新获得一个令牌
  def User.new_token
    SecureRandom.urlsafe_base64
  end


  # 新生成令牌, 装填该用户的remember_token属性, Hash后的令牌落库
  def remember
    self.remember_token = User::new_token
    update_attribute(:rememberme_digest, User::digest(self.remember_token))
  end


  # 验证令牌, 比对toke与DB中的Hash结果的对应关系
  # def authenticated?(rememberme_token)
  #   # DB 中rememberme_digest 字段为空, 则不支持记住我方式登录
  #   return false if self.rememberme_digest.nil?
  #
  #   BCrypt::Password.new(self.rememberme_digest).is_password?(rememberme_token)
  # end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end


  # 删除该用户在DB中的记住我令牌哈希
  def forget
    update_attribute(:rememberme_digest, nil)
  end

  private
  # 在账号创建之前, 先创建一个激活token对应Hash
  def create_activation_digest
    self.activation_token = User::new_token
    self.activation_digest = User::digest(self.activation_token)
  end


end
