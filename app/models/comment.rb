# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :children, class_name: 'Comment', inverse_of: :parent, foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true
end

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint           not null
#  parent_id  :bigint
#  post_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_author_id  (author_id)
#  index_comments_on_parent_id  (parent_id)
#  index_comments_on_post_id    (post_id)
#
# rubocop:enable Layout/LineLength
