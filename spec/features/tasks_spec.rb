require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  scenario "user toggles a task", js: true do

  	user = FactoryBot.create(:user)
  	project = FactoryBot.create(:project,
  		name: "RSpec tutorial",
  		owner: user)
  	# 統合テストは失敗箇所を明確にさせるため、
  	# create! で、DBへの登録が失敗したら例外処理で即時終了させる
  	task = project.tasks.create!(name: "Finish RSpec tutorial")

  	visit root_path
  	click_link "Sign in"
  	fill_in "Email", with: user.email
  	fill_in "Password", with: user.password
  	click_button "Log in"

  	click_link "RSpec tutorial"
  	check "Finish RSpec tutorial"

  	expect(page).to have_css "label#task_#{task.id}.completed"
  	expect(task.reload).to be_completed

  	uncheck "Finish RSpec tutorial"

  	expect(page).to have_css "label#task_#{task.id}.completed"
  	expect(task.reload).to_not be_completed
  end
end
