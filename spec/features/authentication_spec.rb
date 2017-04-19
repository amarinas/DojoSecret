require 'rails_helper'
feature 'authentication' do
  before do
    @user = create(:user)
  end
  feature "user sign-in" do
    scenario 'visit sign-in page' do
    visit '/sessions/new'
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end
  scenario 'logs in user if email/password combination is valid' do
    log_in
    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).to have_text(@user.name)
  end
end

end
