class HomeController < ApplicationController
  def index
    @conversations = current_user.conversations if user_signed_in?
    @q = Item.ransack(params[:q])

    @items = Item.where(status: 'open').sort_by(&:created_at).reverse # User not logged in
    return unless user_signed_in?

    @items = current_user.find_available_items

    return if current_user.locations.first.nil?

    @items = current_user.items_from_user(nil)[0] + current_user.items_from_user(nil)[1]
    return if params[:q].nil?

    @items = current_user.items_from_user(@q.result)[0] + current_user.items_from_user(@q.result)[1]
  end
end
