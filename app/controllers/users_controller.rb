class UsersController < ApplicationController
	def index 
		if params[:previus_limit]
			@limit = params[:previus_limit].to_i + 10
		else
			@limit = 3
		end
		@all_users_count = User.count
		@users = User.all.order("name").limit(@limit)
		@options = {users: @users, limit: @limit}
		respond_to do |format|
			format.html
			format.js{@options}
		end
	end

	def show 
		@user = User.find_by_user_name(params[:user_name]) || not_found
	end

	def search 
		@users = User.search(params[:search])
		respond_to do |format|
			format.html
			format.js {@users}
		end
	end

	def roles 
		@user = User.find(10)
	end
end
