require 'pry-rails'
class Group < ActiveRecord::Base

  has_many :user_groups
  has_many :users, through: :user_groups

  has_many :posts

  validates :name, presence: true
  validates :creator, presence: true
  validates :grouptype, presence: true, format: { with: /(interest|individual)/ }

#The top 3 most popular posts (determined by the number of comments)
  def top_posts(this_number)

   posts.sort_by {|post| post.comments.count}.reverse.shift(this_number)
  end

  def number_of_posts
    posts.count
  end
end
