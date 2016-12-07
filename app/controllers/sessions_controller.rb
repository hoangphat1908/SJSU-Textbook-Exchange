class SessionsController < ApplicationController
  def new
  end

  #Reference: Ruby On Rails Tutorial by Michael Hartl, Chapter 8
  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
      if user.email_confirmed  #Reference: Email Confirmation tutorial https://coderwall.com/p/u56rra/ruby-on-rails-user-signup-email-confirmation-tutorial
        log_in user
        redirect_to user
      else
        flash.now[:danger] = 'You have not activate your account. Please follow the link sent to your email to activate'
        render 'new'
      end
  	else
  	  flash.now[:danger] = 'Invalid email/password combination'
  	  render 'new'
  	end
  end

  def destroy
      log_out
      redirect_to root_path
  end

end
