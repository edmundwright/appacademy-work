class SessionsController < ApplicationController

  skip_before_action :require_signed_in, except: :destroy

  def new

  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]

    )
    if user
      sign_in!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Username or password is wrong"]
      render :new
    end
  end

  def destroy
    sign_out!
    redirect_to new_session_url
  end


end
