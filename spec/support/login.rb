module LoginModule
  def login
    @user = create(:user, email: "test@com", name: "test", password: "password")
    visit login_path
    fill_in 'email', with: "test@com"
    fill_in 'password', with: "password"
    click_button 'ログイン'
  end
end
