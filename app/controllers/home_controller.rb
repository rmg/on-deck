class HomeController < ApplicationController
  def index
    current_domain = current_user ? current_user.domain : nil
    @users = User.and_skills.in_domain(current_domain)
    @skills = Skill.and_users.in_domain(current_domain)
  end
end
