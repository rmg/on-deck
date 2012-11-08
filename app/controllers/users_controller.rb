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
    @user.skills_list = params[:user][:skills_list]
    if @user.save
      redirect_to @user
    else
      render :edit
    end
  end


def show
    @user = User.find(params[:id])
  end

end
