require 'spec_helper'

describe "Authentication" do
  describe "sign-in page" do
    before {  visit signin_path  }
    it "should be there (200)" do
      get signin_path
      response.status.should be(200)
    end
    it "should have an h1 with \"Sign In\"" do
      page.should have_selector('h1', text: 'Sign In')
    end
    it "should have a link to the sign up page" do
      page.should have_link('Sign up', href: signup_path)
    end
    it "should display an error when auth fails" do
			click_button 'Submit'
    	page.should have_selector('div.alert.alert-error', text: 'Invalid')
    end
		describe "with a valid sign in" do
			before do
	  		let(:user) do
		  		User.create(
		  			name: 'John Smith',
		  			email: 'jsmith@example.com',
		  			password: 'foobar',
		  			password_confirmation: 'foobar'
		  		)
		  	end
				fill_in 'user[email]',    with: user.email
				fill_in 'user[password]',	with: user.password
				click_button 'Submit'	
			end
	    it "should go to user's profile" do
				page.should have_selector('h1', text: user.name)
	    end
			it "should have a profile link" do
				page.should have_link('Profile', href: user_path(user))
			end
			it "should have a sign out link" do
				page.should have_link('Sign out', href: signout_path)
			end
			it "should not have a sign in link" do
				page.should_not have_link('Sign in', href: signin_path)
			end
		end
  end
end