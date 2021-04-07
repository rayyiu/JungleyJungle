class User < ActiveRecord::Base
    has_secure_password
    validates :password, presence: true, length: { minimum: 5 }
    validates :name, presence: true 
    validates :email, uniqueness: {case_sensitive: false}, presence: true

    def self.authenticate_with_credentials(email, password) 
    user = User.find_by_email(email.strip.downcase)
        if (user && user.authenticate(password))
            return user 
        else 
            return nil
        end 
    end 
end
