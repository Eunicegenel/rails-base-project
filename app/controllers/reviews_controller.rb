class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def new
    @review = Review.new
    @conversations = current_user.conversations
    @item = Item.find(params[:item_id])
    @user1 = @item.user                             # user1 is the item owner ('seller')
    @transact = Transact.find(params[:transact_id])
    @user2 = User.find(@transact.user2_id) # user2 is the one who availed the item ('buyer')
  end

  def create
    @review = Review.new(review_params)
    # check first if review already exists
    if params[:review][:user1_id].nil?                 # user1 is giving the review
      @subject = User.find(params[:review][:user2_id])
      review_check = Review.find_by(transact_id: params[:transact_id], user2_id: params[:review][:user2_id])
      review_check&.delete
      score = params[:review][:user2_score]
    elsif params[:review][:user2_id].nil?              # user2 is giving the review
      @subject = User.find(params[:review][:user1_id])
      review_check = Review.find_by(transact_id: params[:transact_id], user1_id: params[:review][:user1_id])
      review_check&.delete
      score = params[:review][:user1_score]
    end

    if @review.save
      # update subject ave_rating
      # score = (params[:review][:user1_score] || params[:review][:user2_score])
      @subject.update_rating(score.to_i)
      redirect_to root_path, notice: 'Review was submitted succesfully.'
    else
      redirect_to request.referer, alert: 'Review failed to submit.'
    end
  end

  private

  def review_params
    params.require(:review).permit(:transact_id, :user1_id, :user2_id, :user1_score, :user2_score, :description, :traded_with)
  end
end
