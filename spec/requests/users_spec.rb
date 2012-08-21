require 'spec_helper'

describe "Users controller" do
#   describe "signup page" do
#     it "should be there (200)" do
#       get user_path
#       response.status.should be(200)
#     end
#   end
  describe "profile page (users#show)" do
  	let(:user) do
  		User.create(
  			name: 'John Smith',
  			email: 'jsmith@example.com',
  			password: 'foobar',
  			password_confirmation: 'foobar'
  		)
  	end
  	before { visit user_path(user) }
  	it "should have an <h2> of the user's name" do
  		page.should have_selector('h2', text: user.name)
  	end
  	it "should have an <p> of the user's email" do
  		page.should have_selector('p', text: user.email)
  	end
  end

  describe "signup page (users#new)" do

  	before { visit signup_path }

  	it "should not create a new user if form is blank" do
	  	expect { click_button 'Submit' }.not_to change(User, :count)
	  end
	  
	  it "should create a user if form is filled out correctly" do
			fill_in 'user[name]',         					with: 'John User'
			fill_in 'user[email]',    					    with: 'john@example.com'
			fill_in 'user[password]',								with: 'foobar'
			fill_in 'user[password_confirmation]',	with: 'foobar'
			expect do
			  click_button 'Submit'
			end.to change(User, :count).by(1)
		end
  end
end