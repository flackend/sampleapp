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
    it "should go to user's profile when the form is filled out correctly" do
  		User.create(
  			name: 'John Smith',
  			email: 'jsmith@example.com',
  			password: 'foobar',
  			password_confirmation: 'foobar'
  		)
			fill_in 'user[email]',    					    with: 'jsmith@example.com'
			fill_in 'user[password]',								with: 'foobar'
			click_button 'Submit'
			page.should have_selector('h1', text: 'John Smith')
    end
  end
end
