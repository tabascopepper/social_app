# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :followed_relationships, class_name: 'Subscription', foreign_key: 'follower_id', inverse_of: :follower, dependent: :destroy
  has_many :following, through: :followed_relationships, source: :followed
  has_many :follower_relationships, class_name: 'Subscription', foreign_key: 'followed_id', inverse_of: :followed, dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def follow(other_user)
    followed_relationships.create(followed_id: other_user.id) unless following?(other_user)
  end

  def unfollow(other_user)
    followed_relationships.find_by(followed_id: other_user.id)&.destroy if following?(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           not null
#  last_name              :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
