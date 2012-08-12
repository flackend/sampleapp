require 'spec_helper'

describe "Site controller" do
  describe "index page" do
    it "should be there (200)" do
      get root_path
      response.status.should be(200)
    end
    it "should have a link for the /signup page" do
      visit root_path
      page.should have_selector('a', content: 'Sign up')
    end
  end
end
