class User < ActiveRecord::Base
    has_secure_password
    validates :password, presence: true, length: { minimum: 5 }
    validates :name, presence: true 
    validates :email, uniqueness: {case_sensitive: false}, presence: true
end
