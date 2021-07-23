class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, :last_name, :contact, :address, presence: true
  validates :username, presence: true, uniqueness: true

  validate :avatar_filesize

  has_one_attached :avatar
  has_many :items, dependent: :destroy
  has_many :locations, class_name: 'Location', dependent: :restrict_with_exception
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :restrict_with_exception
  # how to approach dependence of messages? if a message is destroyed, the other user's copy should not be automatically deleted
  has_many :messages, dependent: :destroy

  def conversations
    # return all conversations where the current_user is a part of
    a = Conversation.where(user1_id: self)
    b = Conversation.where(user2_id: self)
    a.or(b).uniq
  end

  def thumbnail
    avatar.variant(combine_options: { thumbnail: '300x300^', gravity: 'center', extent: '300x300' })
  end

  def update_rating(score)
    self.ave_rating = 0 if ave_rating.nil?
    # REVIEW: = Review.find_by(transact_id: transact_id, user1_id: user_id) || Review.find_by(transact_id: transact_id, user2_id: user_id)
    count = (Review.where(user1_id: id) + Review.where(user2_id: id)).count
    self.ave_rating = (ave_rating * (count - 1) + score) / count
    save
  end

  def history_items
    a = items.where(status: 'traded')
    a = a.to_ary
    transacts = Transact.where(user2_id: id)
    transacts = transacts.to_ary
    transacts.to_ary.each do |t|
      a << t.item
    end
    a
  end

  def lat
    locations.first.latitude
  end

  def long
    locations.first.longitude
  end

  def item_search_params(search)
    if search.nil?
      Item.where(status: 'open').sort_by(&:created_at).reverse
    else
      search.where(status: 'open').sort_by(&:created_at).reverse
    end
  end

  def find_available_items
    items = Item.where('user_id not in(?)', id) # item with same user id as current user not displayed
    items.where(status: 'open').sort_by(&:created_at).reverse if locations.first.nil?
    # sort items above accdng if unverified current user
  end

  def items_from_user(input)
    items_arr = []
    nodist_arr = []

    final_arr = []
    lat1 = lat
    long1 = long

    item_search_params(input).each do |item|
      if item.user.locations.first.nil?
        nodist_arr.push(item)
        next
      elsif item.user == self
        next
      end
      lat2 = item.user.lat
      long2 = item.user.long
      dist = Location.distance(lat1, lat2, long1, long2)
      items_arr.push([item.id, dist])
    end

    items_arr.sort_by(&:last).each do |n|
      final_arr.push(Item.find(n[0]))
    end
    [final_arr, nodist_arr]
  end

  def top_ratings
    top_comments = []
    a = Review.where(user1_id: id).to_ary
    b = Review.where(user2_id: id).to_ary
    (a + b).each do |entry|
      score = entry.user1_score || entry.user2_score
      Review.where(id: entry.id)
      # score_given_by = entry.user1_id || entry.user2_id
      top_comments << [score, entry.description]
    end
    top_comments.sort.reverse
  end

  private

  def avatar_filetype
    errors.add(:avatar, 'needs to be of the following format: JPEG, JPG, or PNG') if avatar.content_type.in?(%('image/jpeg image/jpg image/png image/JPEG image/JPG image/PNG'))
  end

  def avatar_filesize
    errors.add(:avatar, 'file size should not exceed 1 MB!') if avatar.attached? && avatar.byte_size >= 1.megabyte
  end
end
