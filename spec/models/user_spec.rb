require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validation' do 
    it "should save successfully" do 
      @user = User.create(name: "Nikola Jokic", email: "joker@jokes.com", password: "password", password_confirmation: "password")
      expect(@user).to be_present
    end 

    context "given missing, incorrect, or existing name, email or password" do
     it "should require name" do 
      @user = User.create(name: nil, email: "joker@jokes.com", password: "password", password_confirmation: "password") 
      expect(@user.errors.full_messages[0]).to eq("Name can't be blank")
     end 
     it "should require a password when signing up" do
      @user = User.create(name: "Niky Jokic", email: "joke@joke.com", password: nil, password_confirmation: nil)
      expect(@user.errors.full_messages[0]).to eq("Password can't be blank")
     end 
     it "should have the same password for both password fields" do 
      @user = User.create(name: "Nikola Jokic", email: "joker@jokes.com", password: "password", password_confirmation: "password2")
      expect(@user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end 
    it "should require a password over five characters" do 
      @user = User.create(name: "Nikola Jokic", email: "joker@jokes.com", password: "ya", password_confirmation: "ya")
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 5 characters)")
    end
     it "should require an email when siging up" do 
      @user = User.create(name: "Nikola Jokic", email: nil, password: "password", password_confirmation: "password") 
      expect(@user.errors.full_messages[0]).to eq("Email can't be blank")
    end 
    it "should require a unique email when signing up" do 
      @user1 = User.create(name: "Nikola Jokic", email: "joke@nuggets.com", password: "password", password_confirmation: "password")
      @user2 = User.create(name: "Nikola Jokic", email: "joke@nuggets.com", password: "password", password_confirmation: "password")  
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end
  end
end
 describe '.authenticate_with_credentials' do 
  it "should log the user in when given the proper credentials" do 
   User.create(name: "Nikola Jokic", email: "joke@nuggets.com", password: "password", password_confirmation: "password")
   @user_login = User.authenticate_with_credentials("joke@nuggets.com", "password")
   expect(@user_login[:name]).to eq("Nikola Jokic")
   expect(@user_login[:email]).to eq("joke@nuggets.com")
  end
  it "should not login with false credentials" do 
    @false_user = User.authenticate_with_credentials("123@soulja.boy", "TellEmSoulja")
    expect(@false_user).to be_nil 
  end 
  it "should log a user in with trailing spaces in the email field" do
    User.create(name: "Nikola Jokic", email: "joke@nuggets.com", password: "password", password_confirmation: "password")
    @user_login = User.authenticate_with_credentials("   joke@nuggets.com   ", "password")
    expect(@user_login[:name]).to eq("Nikola Jokic")
    expect(@user_login[:email]).to eq("joke@nuggets.com")
  end
  it "should login a user if the casing in their email is different" do 
    User.create(name: "Nikola Jokic", email: "joke@nuggets.com", password: "password", password_confirmation: "password")
    @user_login = User.authenticate_with_credentials("jOkE@nuGgets.com", "password")
    expect(@user_login[:name]).to eq("Nikola Jokic")
    expect(@user_login[:email]).to eq("joke@nuggets.com")
  end 
 end 
end
