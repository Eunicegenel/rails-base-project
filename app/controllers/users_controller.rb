class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @conversations = current_user.conversations.sort_by(&:created_at).reverse
    @q = Item.ransack(params[:q])
  end

  def history
    @q = Item.ransack(params[:q])
    @user = User.find(params[:id])
    @conversations = current_user.conversations.sort_by(&:created_at).reverse
    @history_items = @user.history_items
  end

  # def user_params
  #     params.require(:user).permit()
  # end
end
