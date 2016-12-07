class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.jsons
  def show
    @user = User.find(params[:id])
    # @posts = @user.posts
    @posts = @user.posts.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        UserMailer.registration_confirmation(@user).deliver_now
        format.html { redirect_to root_url, notice: 'Welcome to our website, please confirm your email' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, notice: 'Something is wrong in creating your account' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  #Reference: Email Confirmation Tutorial https://coderwall.com/p/u56rra/ruby-on-rails-user-signup-email-confirmation-tutorial
  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = 'Your account has been successfully confirmed'
      redirect_to root_url
    else
      flash[:error] = 'Error: User does not exist.'
      redirect_to root_url
    end 
  end

  
  private
    def set_user
      @user = User.find(params[:id])
    end


    def user_params
      params.require(:user).permit(:first, :last, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "please log in"
        redirect_to login_url
      end
    end
    
     #make sure if the one doing action is the correct user
    def correct_user
      @user = User.find(params[:id])
      unless @user == current_user
        flash[:notice] = "You can only edit your own account"
        redirect_to({:controller => 'users', :action =>'show'}) 
      end
    end
   

end 
