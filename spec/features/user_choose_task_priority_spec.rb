require 'rails_helper'

feature 'User choose task priority' do
  scenario 'successfully' do
    user = create(:user)
    create(:task, priority: :default, user: user)

    login_as(user, scope: :user)
    visit root_path
    all(:css, 'i.priority-default')[0].click
    click_on 'Prioridade 1'
  end
end