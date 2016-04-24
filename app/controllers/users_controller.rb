class UsersController < ApplicationController
  before_action { authorize User }

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def edit    
    @user = current_user
  end

  def update
    @user = current_user
    @user.skip_password_validation = true
    if @user.update_attributes(user_params)
      redirect_to account_path
    else
      render :edit
    end
  end  

  private
  
    def user_params
      params.require(:user).permit(
        :firstname,
        :lastname,
        :login,
        :email,
        :birthdate,
        :phone,
        :password,
        :password_confirmation
      )
    end

    def not_authorized
      ['new', 'create'].include?(action_name) ? redirect_to(root_path) : super
    end
end
