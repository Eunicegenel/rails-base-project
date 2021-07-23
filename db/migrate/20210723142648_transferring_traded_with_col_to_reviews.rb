class TransferringTradedWithColToReviews < ActiveRecord::Migration[6.0]
  def change
    remove_column :transacts, :traded_with
    add_column :reviews, :traded_with, :string
  end
end
