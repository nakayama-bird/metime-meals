require 'rails_helper'
RSpec.describe 'Posts', type: :system do
  let(:user){ create(:user) }
  let(:post){ create(:post) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context '新規投稿ページにアクセス' do
        it '新規登録ページへのアクセスが失敗する' do
          visit new_post_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context '投稿編集ページにアクセス' do
        it '投稿編集ページへのアクセスが失敗する' do
          visit edit_post_path(post)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context '投稿詳細ページにアクセス' do
        it '投稿の詳細ページが表示される' do
          visit post_path(post)
          expect(page).to have_content post.restaurant_name
          expect(current_path).to eq post_path(post)
        end
      end

      context '投稿一覧(カード)にアクセス' do
        it 'すべての投稿が表示される' do
          post_list = create_list(:post, 3) #配列になっている
          visit posts_path
          expect(page).to have_content post_list[0].restaurant_name
          expect(page).to have_content post_list[1].restaurant_name
          expect(page).to have_content post_list[2].restaurant_name
          expect(current_path).to eq posts_path
        end
      end

      context '投稿一覧(マップ)にアクセス' do
        xit 'すべての投稿が表示される' do

        end
      end
    end
  end

  describe 'ログイン後' do
  before { login_as(user) }

    describe '投稿編集' do
      context '他ユーザーの投稿編集ページにアクセス' do
        xit '編集ページへのアクセスが失敗する' do
          # アクセス禁止に関わる処理を実装していないためスキップ
        end
      end
    end

    describe '投稿削除' do
      it '投稿の削除が成功する' do
        post = create(:post, user: user, restaurant_name: 'レストラン削除', body: 'さようなら')
        visit post_path(post)
        click_on '削除'
        page.accept_alert '投稿を削除しますか？'
        expect(page).to have_content('投稿を削除しました')
        expect(current_path).to eq posts_path
      end
    end
  end
end
