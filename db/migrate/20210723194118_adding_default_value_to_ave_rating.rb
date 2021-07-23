class AddingDefaultValueToAveRating < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :ave_rating, 0.0
  end
end
