module LoginMacros
  def login_as(user)
    visit root_path
    click_link 'ログインする'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    visit current_path
  end
end
