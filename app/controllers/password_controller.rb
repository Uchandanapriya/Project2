class PasswordController < ApplicationController
  def forget_password
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user
        new_password = create_random_password
        @user.update(password: new_password)
        puts "=========="
        puts new_password

        redirect_to account_login_url
        
        
      else
        flash[:notice] = "Invalid email id .please enter a valid email"
        render :action=>:"forget_password"
      end

    end
  end

    def create_random_password
      (0...6).map {(65 + rand(26)).chr }.join
    end

  def reset_password
    @user = User.find(session[:user])
    if request.post?
    if @user
      #unless params[:password].nil || params[:password] == "" ||params[:password] == nil
      if @user.update(:password=>params[:password])
      #acton mailer
      flash[:notice] = "Your password has been reset."
      redirect_to account_dashboard_url
      else
      flash[:notice] = "enter valid password"
      render :action=>:reset_password
      end
    end
  end
  end
end