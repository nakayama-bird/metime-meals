require 'rails_helper'

RSpec.describe Post, type: :model do
  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      post = build(:post)
      expect(post).to be_valid
    end
  end

  context '店名が存在しない場合' do
    it '無効であること' do
      post = build(:post, restaurant_name: nil)
      expect(post).to be_invalid
      expect(post.errors[:restaurant_name]).to include('を入力してください')
    end
  end

  context '本文が存在しない場合' do
    it '無効であること' do
      post = build(:post, body: nil)
      expect(post).to be_invalid
      expect(post.errors[:body]).to include('を入力してください')
    end
  end

  context '店名が255文字以下の場合' do
    it '有効であること' do
      post = build(:post, restaurant_name: 'a' * 255)
      expect(post).to be_valid
    end
  end

  context '店名が256文字以上の場合' do
    it '無効であること' do
      post = build(:post, restaurant_name: 'a' * 256)
      expect(post).to be_invalid
      expect(post.errors[:restaurant_name]).to include('は255文字以内で入力してください')
    end
  end

  context '本文が65535文字以内の場合' do
    it '有効であること' do
      post = build(:post, body: 'a' * 65535)
      expect(post).to be_valid
    end
  end

  context '本文が65536文字以上の場合' do
    it '無効であること' do
      post = build(:post, body: 'a' * 65536)
      expect(post).to be_invalid
      expect(post.errors[:body]).to include('は65535文字以内で入力してください')
    end
  end

  context 'ジャンルの選択がない場合' do
    it '無効であること' do
      post = build(:post, genre: nil)
      expect(post).to be_invalid
      expect(post.errors[:genre]).to include('を入力してください')
    end
  end

  context 'おすすめ度の選択がない場合' do
    it '無効であること' do
      post = build(:post, rating: nil)
      expect(post).to be_invalid
      expect(post.errors[:rating]).to include('を入力してください')
    end
  end

  context '使った金額が登録できること' do
    it '有効であること' do
      post = build(:post)
      post.amount = (0..6).to_a.sample
      expect(post).to be_valid
    end
  end
end
