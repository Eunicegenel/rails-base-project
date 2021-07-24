class Review < ApplicationRecord
  belongs_to :transact

  validates :description, presence: true, length: { minimum: 20, maximum: 250 }
end
