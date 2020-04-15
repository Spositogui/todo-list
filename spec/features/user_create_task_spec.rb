require 'rails_helper'

feature 'User create a new task' do
  scenario 'successfully', js: true do
    user = create(:user)
    total = Task.count

    login_as(user, scope: :user)
    visit root_path
    click_on 'Nova tarefa'

    fill_in 'Título', with: 'Comprar pão'
    fill_in 'Descrição', with: 'Pariatur Lorem esse tempor fugiat velit qui.'
    click_on 'Criar'

    expect(page).to have_content('Comprar pão')
    expect(Task.count).to eq(total + 1)
  end

  scenario 'and alredy had a task', js: true do
    user = create(:user)
    create(:task, title: 'Tarefa 1', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Nova tarefa'
    fill_in 'Título', with: 'Tarefa 2'
    click_on 'Criar'

    expect(page).to have_content('Tarefa 1')
    expect(page).to have_content('Tarefa 2')
    expect(Task.count).to eq(2)
  end

  scenario 'and must fill in mandatory title field', js: true do
    user = create(:user)
    total = Task.count

    login_as(user, scope: :user)
    visit root_path
    click_on 'Nova tarefa'
    fill_in 'Descrição', with: 'Do ut nulla minim irure aliquip do.'
    click_on 'Criar'

    expect(Task.count).to eq(total)
    expect(page).to have_content("Title can't be blank")
  end
end
