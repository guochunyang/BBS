# coding: utf-8
class User < ActiveRecord::Base

  before_save {self.username = username.downcase}
  before_save {self.email = email.downcase}
  before_create :generate_remember_token


  validates :username,
            :presence => true,
            :length => {:maximum => 20},
            :uniqueness => {:case_sensitive => false}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
            :presence => true,
            :format => {:with => VALID_EMAIL_REGEX},
            :uniqueness => {:case_sensitive => false}

  validates :password,
            :presence => true,
            :length => {:minimum => 8,
                        :maximum => 20},
            :confirmation => {:message => '两次密码不一致'}

  validates :password_confirmation,
            :presence => true

  #validates_confirmation_of :password, :message => "两次密码不一致"


  def password
		@password
  end


  def password=(pass)
    return unless pass
    @password = pass
    generate_password(pass)
  end

  def password_confirmation
    @password_confirmation
  end

  def password_confirmation=(pass)
    return unless pass
    @password_confirmation = pass
  end


  # 密码认证
  def authenticate(pass)
    if Digest::SHA256.hexdigest(pass + self.salt) == self.hashed_password
      return self
    end
    false
  end


  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    def generate_password(pass)
      salt = Array.new(10){rand(1024).to_s(36)}.join
      self.salt, self.hashed_password =
          salt, Digest::SHA256.hexdigest(pass + salt)
    end

    def generate_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end


end
