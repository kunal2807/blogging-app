class SessionsController < ApplicationController

  def new
    
  end

  def create
    sess = params[:session]
    user = User.find_by(email: sess[:email].downcase)
    if user && user.authenticate(sess[:password])
      session[:user_id] = user.id
      flash[:success] = 'Login in successfull'
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Incorrect credentials"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end