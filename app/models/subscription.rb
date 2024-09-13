# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
end

# == Schema Information
#
# Table name: subscriptions
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :integer          not null
#  follower_id :integer          not null
#
# Indexes
#
#  index_subscriptions_on_followed_id  (followed_id)
#  index_subscriptions_on_follower_id  (follower_id)
#
# rubocop:enable Layout/LineLength
