class UsersController < ApplicationController
	def index 
		@users = User.all.limit(25)
	end

	def show 
		@user = User.find_by_user_name(params[:user_name]) || not_found
	end

	def search 
		@users = User.search(params[:search])

	end
end
