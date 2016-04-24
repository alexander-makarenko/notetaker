class SessionsController < ApplicationController
  before_action { authorize :session }

  def new
  end

  def create
    user = User.find_by(login: params[:login].downcase)
    
    if user.try(:authenticate, params[:password])
      sign_in(user, params[:keep_signed_in])
      redirect_back_or root_path
    else
      flash.now[:danger] = 'Invalid login or password'
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

    def not_authorized
      redirect_to root_path
    end
end