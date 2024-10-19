require 'rails_helper'
RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }
  describe 'ログイン前' do
    describe 'ユーザーの新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          visit new_user_path
          fill_in '名前', with: 'なかじ'
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に成功しました'
          expect(current_path).to eq root_path
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit new_user_path
          fill_in '名前', with: 'なかじ'
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(current_path).to eq  new_user_path
        end
      end

      context '登録済みのメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in '名前', with: 'なかじ'
          fill_in 'メールアドレス', with: existed_user.email
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'メールアドレスはすでに存在します'
          expect(current_path).to eq  new_user_path
          expect(page).to have_field 'メールアドレス', with: existed_user.email
        end
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページのアクセスが失敗する' do
          visit mypage_bookmark_posts_path(user)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login_as(user) }

    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          visit edit_mypage_profiles_path(user)
          fill_in '名前', with: '太郎'
          select '女性', from: 'user_gender'
          select '20代', from: 'user_age'
          click_button '登録'
          expect(page).to have_content('ユーザー情報の更新に成功しました')
          expect(current_path).to eq mypage_profiles_path
        end
      end

      context  '名前が未入力' do
        it 'ユーザーの編集が失敗する' do
          visit edit_mypage_profiles_path(user)
          fill_in '名前', with: ''
          click_button '登録'
          expect(page).to have_content 'ユーザー情報の更新に失敗しました'
          expect(page).to have_content '名前を入力してください'
          expect(current_path).to eq  mypage_profiles_path
        end
      end
    end
    describe 'マイページ' do
      context '投稿を作成' do
        it '新規作成した投稿が表示される' do
          create(:post, restaurant_name: 'レストランテスト', body: 'とてもおいしい', user: user )
          visit mypage_posts_path
          expect(page).to have_content('レストランテスト')
          expect(page).to have_content('とてもおいしい')
        end
      end
      # 投稿を作成
      # その投稿をお気に入り
      # 自分のお気に入り一覧で表示
      context '投稿をお気に入り' do
        it 'お気に入りした投稿が表示される' do
          post = create(:post, restaurant_name: 'レストランお気に', body: 'とてもおいしいな', user: user )
          visit post_path(post)
          link = find("#bookmark-button-for-post-#{post.id}")
          link.click
          visit current_path
          visit mypage_bookmark_posts_path
          expect(page).to have_content('レストランお気に')
          expect(page).to have_content('とてもおいしいな')
        end
      end
    end
  end
end
