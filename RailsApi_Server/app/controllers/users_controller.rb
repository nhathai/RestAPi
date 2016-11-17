class UsersController < ApplicationController
  # require 'rest_client'
  http_basic_authenticate_with :name => "test", :password => "test"

  skip_before_filter  :verify_authenticity_token
  skip_before_filter :authenticate_user!

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # before_filter :fetch_user, :except => [:index, :create]
  #
  # def fetch_user
  #   @user = User.find_by_id(params[:id])
  # end

  def index
    @users = User.all
    # respond_to do |format|
    #   format.html
    #   format.json { render json: @users }
    # end
  end

  # GET /users/1
  # GET /users/1.json
  def show
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

    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        #format.json { render json: @user, status: :created }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :username, :passord, :email, :birthday, :gender, :status)
    end
end
