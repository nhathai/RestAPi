class UsersController < ApplicationController
  require 'rest_client'

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  http_basic_authenticate_with :name => "test", :password => "test"

  # GET /users
  # GET /users.json
   USERNAME = "test" # needed to access the APi
   PASSWORD = "test" # needed to access the APi
   API_BASE_URL = "http://localhost:3000/api/v1" # base url of the API
  #
  def index
    uri = "#{API_BASE_URL}/users.json"
    rest_resource = RestClient::Resource.new(uri,USERNAME, PASSWORD)
    users = rest_resource.get
    @users = JSON.parse(users, :symbolize_names => true)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  # def new
  #    @user = User.new
  # end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json

  def create
    uri = "http://localhost:3000/api/v1/users"
    payload = params.to_json # converting the params to json
    rest_resource = RestClient::Resource.new(uri, USERNAME, PASSWORD)
    begin
      rest_resource.post payload , :content_type => "application/json"
      flash[:notice] = "User Saved successfully"
      redirect_to users_path # take back to index page, which now list the newly created user also
    # rescue RestClient::ExceptionWithResponse => e
    #   e.response
    rescue Exception => e
      flash[:error] =  "User Failed to save"
      render :new
    end
  end

  # def create
  #   @user = User.new(user_params)
  #
  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end


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
      params.require(:user).permit(:id, :firstname, :lastname, :username, :passord, :email, :birthday, :gender, :status)
    end
end
