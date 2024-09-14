# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'full_name' do
    subject { user.full_name }

    let(:user) { build(:user, first_name: 'John', last_name: 'Doe') }

    it { is_expected.to eq('John Doe') }
  end

  describe 'subscribtions' do
    let(:user) { build_stubbed(:user) }
    let(:other_user) { create(:user) }

    describe 'following?' do
      subject { user.following?(other_user) }

      context 'when user is following the other user' do
        before { user.follow(other_user) }

        it { is_expected.to be true }
      end

      context 'when user is not following the other user' do
        it { is_expected.to be false }
      end
    end

    describe 'follow' do
      subject(:follow) { user.follow(other_user) }

      it 'creates a following relationship' do
        expect { follow }.to change(user.following, :count).by(1)
      end
    end

    describe 'unfollow' do
      subject(:unfollow) { user.unfollow(other_user) }

      context 'when user is following the other user' do
        before { user.follow(other_user) }

        it 'destroys the following relationship' do
          expect { unfollow }.to change(user.following, :count).by(-1)
        end
      end

      context 'when user is not following the other user' do
        it 'does not destroy the following relationship' do
          expect { unfollow }.not_to change(user.following, :count)
        end
      end
    end
  end
end
