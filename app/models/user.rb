class User < ActiveRecord::Base
  
  attr_accessible :email, :name
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validate :email, :presence => true, 
                   :format   => {:width => email_regex},
                   :uniqueness => {:case_sensitive => false}
                   
  validate :name, :presence => true,
                  :length => {:maximum => 20}
  
  
end
