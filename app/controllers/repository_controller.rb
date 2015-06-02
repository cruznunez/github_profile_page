class RepositoryController < ApplicationController
  def form
  end

  def index
    @user = User.new(params[:user_name])
  end
end
