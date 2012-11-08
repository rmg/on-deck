class HomeController < ApplicationController
  def index
    current_domain = current_user ? current_user.domain : nil
    @users = User.in_domain(current_domain)
  end
end
