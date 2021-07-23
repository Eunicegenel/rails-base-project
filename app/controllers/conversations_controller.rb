class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations.sort_by(&:created_at).reverse
    @q = Item.ransack(params[:q])
  end

  def show
    @q = Item.ransack(params[:q])
    @conversation = Conversation.find(params[:id])
    @conversations = current_user.conversations.sort_by(&:created_at).reverse
  end

  def new
    @conversation = Conversation.new
  end

  def create
    Conversation.create(conversation_params) unless Conversation.exists?(conversation_params)
    conv = Conversation.where(conversation_params)
    redirect_to item_conversation_path(params[:item_id], conv.first.id)
  end

  private

  def conversation_params
    params.require(:conversation).permit(:item_id, :user1_id, :user2_id)
  end
end
