class User < ActiveRecord::Base

  before_save {self.username = username.downcase}
  before_save {self.email = email.downcase}

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
                        :maximum => 20}


	def password
		@password
  end


  def password=(pass)
    return unless pass
    @password = pass
    generate_password(pass)
  end


  def authenticate(pass)
    if Digest::SHA256.hexdigest(pass + self.salt) == self.hashed_password
      return self
    end
    false
  end


  private
    def generate_password(pass)
      salt = Array.new(10){rand(1024).to_s(36)}.join
      self.salt, self.hashed_password =
          salt, Digest::SHA256.hexdigest(pass + salt)
    end

end
