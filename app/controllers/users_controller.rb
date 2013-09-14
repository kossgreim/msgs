class UsersController < ApplicationController
	def index 
		@users = User.all
	end

	def show 
		@user = User.find_by_user_name(params[:user_name]) || not_found
	end
end
