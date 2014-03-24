require 'pry-rails'
class User < ActiveRecord::Base


  has_many :user_groups
  has_many :posts
  has_many :comments

  has_many :groups, through: :user_groups

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :ee, presence: true
  # The names of all the groups they belong to
  # The number of posts they've made
  # The number of comments they've made

  def show_groups
    tmp=[]
    groups.each {|one_group| tmp << one_group.name}
    tmp
  end

  def count_number_of_posts
    posts.count
  end

  def count_number_of_comments
    comments.count
  end

end
