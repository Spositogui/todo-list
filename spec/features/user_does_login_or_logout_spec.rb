require 'rails_helper'

feature 'User does login or logout' do
  describe 'login' do
    scenario 'successfully' do
      user = create(:user, email: 'user@example.com')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'

      expect(page).to have_content(user.email)
      expect(page).to have_link('Sair')
      expect(page).to have_link('Nova tarefa')
      expect(page).not_to have_link('Entrar')  
      expect(page).not_to have_content('Bem vindo ao TODOlist')  
    end

    scenario 'and fill with wrong email and password', js: true do
      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'customer@example.com'
      fill_in 'Password', with: '654321'
      click_on 'Log in'

      expect(page).to have_content('Incorrect email or password.')  
    end

    scenario 'and not fill in fields', js: true do
      visit root_path
      click_on 'Entrar'
      click_on 'Log in'

      expect(page).to have_content('Incorrect email or password.')  
    end
  end

  describe 'logout' do
    scenario 'successfully' do
      user = create(:user, email: 'user@example.com')

      login_as(user, scope: :user)
      visit root_path
      click_on 'Sair'

      expect(page).not_to have_content(user.email)
      expect(page).not_to have_link('Sair')
      expect(page).to have_link('Entrar')
      expect(page).to have_content('Bem vindo ao TODOlist')
    end
  end
end