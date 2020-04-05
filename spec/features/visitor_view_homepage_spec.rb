require 'rails_helper'

feature 'Visitor view home page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('Bem vindo ao TODOlist')  
    expect(page).to have_link('Entrar')
  end
end