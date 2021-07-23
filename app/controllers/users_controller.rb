class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @conversations = current_user.conversations
    @q = Item.ransack(params[:q])
  end

  def history
    @user = User.find(params[:id])
    @conversations = current_user.conversations
    @history_items = @user.history_items
  end

  # def user_params
  #     params.require(:user).permit()
  # end
end
