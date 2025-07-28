require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'default_scope' do
    it '作成日時の降順で並んでいる' do
      old = create(:notification, created_at: 2.days.ago)
      new = create(:notification, created_at: 1.day.ago)
      expect(Notification.all).to eq [new, old]
    end
  end

  describe 'association' do
    it 'vtuber' do
      notification = build(:notification, vtuber: nil)
      expect(notification).to be_valid
    end

    it 'visitor' do
      notification = build(:notification, visitor: nil)
      expect(notification).to be_valid
    end

    it 'visited' do
      notification = build(:notification, visited: nil)
      expect(notification).to be_valid
    end

    it 'visitor、visitedが同じクラスである' do
      user = create(:user)
      notification = build(:notification, visitor: user, visited: user)
      expect(notification.visitor).to be_a(User)
      expect(notification.visited).to be_a(User)
    end
  end
end
