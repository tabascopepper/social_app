# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
