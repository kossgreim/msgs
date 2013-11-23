class UsersController < ApplicationController
	def index 
		@users = User.all.order("name").all
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
end
