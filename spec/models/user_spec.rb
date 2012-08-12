# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do

    before do
      @user = User.new(
        name: 'John Smith',
        email: 'jsmith@email.com',
        password: 'foobar',
        password_confirmation: 'foobar'
       )
    end

  # User

  it "should be valid in general..." do
    @user.should be_valid
  end

  # User attributes

  it "should respond to :name, :email, and :password_digest" do
    @user.should(respond_to(:name))
    @user.should(respond_to(:email))
    @user.should(respond_to(:password_digest))
    @user.should(respond_to(:password))
    @user.should(respond_to(:password_confirmation))
    @user.should(respond_to(:authenticate))
  end

  # User :name

  it "should return invalid when name is blank" do
    @user.name = ''
    @user.should_not be_valid
  end

  it "should return invalid when name is > 30 char" do
    @user.name = 'a'*31
    @user.should_not be_valid
  end

  it "should return valid when name is <= 30 char" do
    @user.name = 'a'*30
    @user.should be_valid
  end

  # User :email

  it "should return valid when email is valid" do
    ['a@a.a'].each do |e|
      @user.email = e
      @user.should be_valid
    end
  end

  it "should return invalid when email is invalid" do
    ['a.a.a', '', ' '].each do |e|
      @user.email = e
      @user.should_not be_valid
    end
  end

  it "should return invalid if not unique" do
    @user.save
    @user = User.first.dup
    @user.should_not be_valid
  end

  it "should return invalid if not unique (case-insensitive)" do
    @user.save
    @user = User.first.dup
    @user.email = @user.email.upcase # FIX THIS CASE-SENSITIVITY < < < < < < < < < < < < < < < < < < < <
    @user.should_not be_valid
  end

  # User :password

  it "should not be valid when the password and its confirmation are blank" do
    ['', ' ', 'a'*5 ].each do |p|
      @user.password = @user.password_confirmation = p
      @user.should_not be_valid
    end
  end

  it "should not be valid when password and its confirmation don't match" do
    @user.password_confirmation = 'mismatch...'
    @user.should_not be_valid
  end

  it "should not be valid when password confirmation is nil" do
    @user.password_confirmation = nil
    @user.should_not be_valid
  end

  # User :authenticate

  describe "authentication" do
    before do
      @user.save
    end
    
    let(:u) { User.find_by_email @user.email }

    it "should pass with valid password" do
      @user.should == u.authenticate(@user.password)
    end

    it "should not pass with an invalid password" do
      @user.should_not == u.authenticate('wrong password...')
    end
  end
end
