
module Api
  module V1
    class UsersController < ApplicationController
      respond_to :json

      def index
        respond_with User.all
      end

      def show
        respond_with User.find(params[:id])
      end

      def create
        respond_with User.create(params[:user])
      end

      def update
        respond_with User.update(params[:id], params[:users])
      end

      def destroy
        respond_with User.destroy(params[:id])
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
  end
end

