require 'spec_helper'

describe "Authentication" do

	# sign-in page
  describe "sign-in page" do

    before {  visit signin_path  }

		# exist
    it "should be there (200)" do
      get signin_path
      response.status.should be(200)
    end
    
    # h1
    it 'should have an h1 with "Sign In"' do
      page.should have_selector('h1', text: 'Sign In')
    end
    
    # sign-up link
    it "should have a link to the sign up page" do
      page.should have_link('Sign up', href: signup_path)
    end

		# error msg
		describe "error message" do

			before { click_button 'Submit' }

			# should display after fail
	    it "should display an error when auth fails" do
	    	page.should have_selector('div.alert.alert-error', text: 'Invalid')
	    end
    
	    # should not persist to next page
	    describe "after going to another page" do
		    before { click_link 'Home' }
		    it "should not be displayed" do
		    	page.should_not have_selector('div.alert.alert-error', text: 'Invalid')
		    end
	    end
	  end

    # valid sign-in
		describe "with a valid sign in" do

    	let(:user) do
    		User.create(
    			name: 'John Smith',
    			email: 'john.smith@example.com',
    			password: 'foobar',
    			password_confirmation: 'foobar'
    		)
    	end
    	before do
    		fill_in 'email',    with: user.email
    		fill_in 'password',	with: user.password
    		click_button 'Submit'	
    	end

			# go to profile
	    it "should go to user's profile" do
				page.should have_selector('h2', text: user.name)
	    end
	    
	    # links that should exist or NOT exist after sign-in
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