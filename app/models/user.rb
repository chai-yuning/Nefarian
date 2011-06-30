class User < ActiveRecord::Base
  
  attr_accessor :password
  attr_accessible :email, :name, :password, :password_confirmation
  
  has_many :quests, :dependent => :destroy
    
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, :presence => true, 
                    :format   => {:with => email_regex},
                    :uniqueness => {:case_sensitive => false}                 
                   
  validates :name, :presence => true,
                   :length => {:maximum => 20}
                  
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..20}             
                      
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, salt)
    user = find_by_id(id)
    return nil if user.nil?
    return user if (user && user.salt==salt)
  end  
  
  private 
  
    def encrypt_password
      self.salt = secure_hash("#{Time.now.utc}--#{password}") if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(s)
      secure_hash("#{salt}--#{s}")
    end
    
    def secure_hash(s)
      Digest::SHA2.hexdigest(s)
    end   
  
end
