require 'rails_helper'

feature 'User does login' do
  scenario 'successfully' do
    user1 = create(:user, email: 'user@example.com')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_on 'Log in'

    expect(page).to have_content(user1.email)
    expect(page).to have_content('Sair')
    expect(page).not_to have_content('Entrar')  
  end
end