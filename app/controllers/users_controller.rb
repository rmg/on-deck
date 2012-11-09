class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]

  def index
    current_domain = current_user ? current_user.domain : nil
    @users = User.in_domain(current_domain)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    updated = []
    user_params = params[:user] || {}
    user_params = user_params.merge(params['hidden-user'] || {})
    if user_params[:skills_list]
      updated << "Skills list"
      @user.skills_list = user_params[:skills_list]
    end
    if user_params[:present_until]
      updated << "Status"
      @user.present_until = user_params[:present_until]
    end
    if user_params[:away_until]
      updated << "Status"
      @user.away_until = user_params[:away_until]
    end

    if @user.save
      flash[:notice] = updated.uniq.join(" and ") + ' updated'
    else
      flash[:error] = updated.uniq.join(" and ") + ' not updated'
    end

    redirect_to root_path
  end


def show
    @user = User.find(params[:id])
  end

end
