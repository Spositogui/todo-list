require 'rails_helper'

feature 'User delete task' do
  scenario 'successfully', js: true do
    user = create(:user)
    create(:task, title: 'Importante', user: user)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Deletar'

    expect(page).not_to have_content('Importante')
    expect(Task.count).to eq(0)
  end

  scenario 'and had more than one', js: true do
    user = create(:user)
    create(:task, title: 'Task 1', user: user)
    create(:task, title: 'Task 2', user: user)
    create(:task, title: 'Task 3', user: user)

    login_as(user, scope: :user)
    visit root_path
    page.all(".delete")[0].click
    page.all(".delete")[2].click

    expect(page).to have_content('Task 2')
    expect(page).not_to have_content('Task 1')  
    expect(page).not_to have_content('Task 3')  
  end
end