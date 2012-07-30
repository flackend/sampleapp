require 'spec_helper'

describe "Users controller" do
  describe "signup page" do
    it "should be there (200)" do
      get signup_path
      response.status.should be(200)
    end
  end
end
