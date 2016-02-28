class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = 'Successfully signed in'
      redirect_back_or user
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success] = 'Successfully signed out'
    redirect_to root_url
  end
end
