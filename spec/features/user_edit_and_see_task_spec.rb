require 'rails_helper'

feature 'User edit and view task' do
  #for not use sleep in tests
  Capybara.disable_animation = true

  scenario 'successfully', js: true do
    user = create(:user)
    create(:task, title: 'Comprar pão', description: 'Ea proident id aliquip.',
                  user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Comprar pão'
    fill_in 'Título', with: 'Comprar bolo'
    click_on 'Salvar'

    expect(page).to have_link('Comprar bolo')
    expect(page).not_to have_link('Comprar pão')  
  end

  scenario 'and edit multiples tasks', js: true do
    user = create(:user)
    create(:task, title: 'Tarefa 1', user: user)
    create(:task, title: 'Tarefa 2', description: 'Non nulla anim.', user: user)
    create(:task, title: 'Tarefa 3', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Tarefa 1'
    fill_in 'Título', with: 'A'
    click_on 'Salvar'
    click_on 'Tarefa 3'
    fill_in 'Título', with:'B'
    click_on 'Salvar'
    click_on 'Tarefa 2'
    fill_in 'Descrição', with: 'Ir ao mercado'
    click_on 'Salvar'

    expect(page).to have_content('A')  
    
    task2 = Task.find_by(title: 'Tarefa 2')
    
    expect(task2.description).to eq('Ir ao mercado')  
    expect(page).to have_content('Tarefa 2')  
    expect(page).to have_content('B')  
    expect(page).not_to have_content('Tarefa 1')  
    expect(page).not_to have_content('Tarefa 3')  
    expect(task2.description).not_to have_content('Non nulla anim.')  
  end

  scenario 'and not fill in mandatory fields', js: true do
    user = create(:user)
    create(:task, title: 'Ir ao mercado', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Ir ao mercado'
    fill_in 'Título', with: ''
    click_on 'Salvar'
    
    expect(page).to have_content("Title can't be blank")  
  end
end
