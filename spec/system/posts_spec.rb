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

    describe '新規投稿作成' do
      context 'フォームの入力値が正常' do
        it '新規投稿作成が成功する' do
          visit  new_post_path
          select '中華料理', from: 'post_genre'
          fill_in 'autocomplete', with: 'こんにゃくパーク' # オートコンプリートの都合上autocompleteで指定
          fill_in 'address', with: '日本、〒370-2202 群馬県甘楽郡甘楽町小幡２０４−１' # オートコンプリートの都合上addressで指定
          fill_in 'ひとり外食おすすめポイント', with: 'たくさんこんにゃく食べれます。コニャックじゃないよ。'
          click_button '投稿'
          expect(page).to have_content '投稿に成功しました'
          expect(page).to have_content '中華料理'
          expect(current_path).to eq posts_path
          puts page.body
        end
      end

      context 'おすすめタグを追加' do
        it 'おすすめタグを含んだ新規投稿作成が成功する' do
          visit  new_post_path
          select '中華料理', from: 'post_genre'
          fill_in 'autocomplete', with: 'こんにゃくパーク' # オートコンプリートの都合上autocompleteで指定
          fill_in 'address', with: '日本、〒370-2202 群馬県甘楽郡甘楽町小幡２０４−１' # オートコンプリートの都合上addressで指定
          fill_in 'ひとり外食おすすめポイント', with: 'たくさんこんにゃく食べれます。コニャックじゃないよ。'
          click_link 'ひとり用メニュー'
          click_button '投稿'
          expect(page).to have_content '投稿に成功しました'
          expect(page).to have_content 'ひとり用メニュー'
          expect(current_path).to eq posts_path
        end
      end

      context 'レーティングで評価を追加' do
        it 'レーティングを含んだ新規投稿作成が成功する' do
          visit  new_post_path
          select '中華料理', from: 'post_genre'
          fill_in 'autocomplete', with: 'こんにゃくパーク' # オートコンプリートの都合上autocompleteで指定
          fill_in 'address', with: '日本、〒370-2202 群馬県甘楽郡甘楽町小幡２０４−１' # オートコンプリートの都合上addressで指定
          fill_in 'ひとり外食おすすめポイント', with: 'たくさんこんにゃく食べれます。コニャックじゃないよ。'
          choose 'post_rating_excellent'
          click_button '投稿'
          expect(page).to have_content '投稿に成功しました'
          expect(page).to have_content '5'
          expect(current_path).to eq posts_path
        end
      end

      context 'ジャンルが未入力' do
        it '新規投稿作成が失敗する' do
          visit  new_post_path
          fill_in 'autocomplete', with: 'こんにゃくパーク' # オートコンプリートの都合上autocompleteで指定
          fill_in 'address', with: '日本、〒370-2202 群馬県甘楽郡甘楽町小幡２０４−１' # オートコンプリートの都合上addressで指定
          fill_in 'ひとり外食おすすめポイント', with: 'たくさんこんにゃく食べれます。コニャックじゃないよ。'
          click_button '投稿'
          expect(page).to have_content '投稿に失敗しました'
          expect(page).to have_content 'ジャンルを入力してください'
          expect(current_path).to eq posts_path
        end
      end

      context '住所・店名が未入力' do
        it '新規投稿作成が失敗する' do
          visit  new_post_path
          select '中華料理', from: 'post_genre'
          fill_in 'autocomplete', with: '' # オートコンプリートの都合上autocompleteで指定
          fill_in 'address', with: '' # オートコンプリートの都合上addressで指定
          fill_in 'ひとり外食おすすめポイント', with: 'たくさんこんにゃく食べれます。コニャックじゃないよ。'
          click_button '投稿'
          expect(page).to have_content '投稿に失敗しました'
          expect(page).to have_content 'お店の名前を入力してください'
          expect(page).to have_content '住所を入力してください'
          expect(current_path).to eq posts_path
        end
      end

      context '本文が未入力' do
        it '新規投稿作成が失敗する' do
          visit  new_post_path
          select '中華料理', from: 'post_genre'
          fill_in 'autocomplete', with: 'こんにゃくパーク' # オートコンプリートの都合上autocompleteで指定
          fill_in 'address', with: '日本、〒370-2202 群馬県甘楽郡甘楽町小幡２０４−１' # オートコンプリートの都合上addressで指定
          fill_in 'ひとり外食おすすめポイント', with: ''
          click_button '投稿'
          expect(page).to have_content '投稿に失敗しました'
          expect(page).to have_content 'ひとり外食おすすめポイントを入力してください'
          expect(current_path).to eq posts_path
        end
      end
    end

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
