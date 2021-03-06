require 'spec_helper'

describe SessionsController do
	
  before(:each) do
		OmniAuth.config.test_mode = true
		OmniAuth.config.mock_auth[:google_oauth2] = {
		    'uid' => '12345',
		    'provider' => 'google_oauth2',
		    'info' => {
		      'name' => 'Bob'
		    }
		  }
	end
  
  describe "GET 'new'" do
    it "redirectes users to authentication" do
      get 'new'
      assert_redirected_to '/auth/google_oauth2'
    end
  end
  
  describe "creates new user" do
  	it "redirects new users with blank email to fill in their email" do
  		@user = create(:user)
  		visit '/signin'
  		page.should have_content('Logged in as Bob')
  		page.should have_content('Please enter your email address')
  		current_path.should == edit_user_path(@user)
  	end
  	it "redirects users with email back to root_url" do
  		@user = create(:user, :email => "Tester@testing.com")
  		visit '/signin'
  		page.should have_content('Signed in!')
  		current_path.should == '/'
  	end
  end

end
