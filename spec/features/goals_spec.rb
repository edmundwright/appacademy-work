require 'spec_helper'
require 'rails_helper'
require 'byebug'

feature 'create a goal' do
  before :each do
    sign_up(username: 'Fred', password: 'test_password')
    sign_in(username: 'Fred', password: 'test_password')
  end

  it 'redirects to sign in page if not signed in' do
    click_button "Sign Out"

    visit "/goals/new"
    expect(page).to have_button "Sign In"
  end

  it 'there is a link to create goals' do
    expect(page).to have_content "Add Goal"
  end

  it 'show goal text after creation' do
    add_goal(body: "Goal body test", private: true)
    expect(page).to have_content "Goal body test"
  end

  it 'show whether is private after creation' do
    add_goal(body: "Goal body test", private: true)
    expect(page).to have_content "Private"
  end

  it 'shows error if no goal text provided' do
    add_goal(private: true)
    expect(page).to have_content "Body can't be blank"
  end

  it 'private is selected by default' do
    visit "/goals/new"
    expect(page).to have_field("Private", checked: true)
  end
end

feature 'read a goal' do

  before :each do
    sign_up(username: 'Fred', password: 'test_password')
    sign_in(username: 'Fred', password: 'test_password')
  end

  it 'show whether is public after creation' do
    add_goal(body: "Goal body test", public: true)
    expect(page).to have_content "Public"
  end

  it 'Redirects to index when unauthorized user tries to access private goal' do
    add_goal(body: "Goal body test", private: true)

    click_button "Sign Out"

    sign_up(username: "John", password: "john_password")

    visit "/goals/#{Goal.find_by(body: "Goal body test").id}"
    expect(page).to have_content "Goals Index"
  end

  it 'Shows other user public goal' do
    add_goal(body: "Goal body test", public: true)
    click_button "Sign Out"

    sign_up(username: "John", password: "john_password")
    visit "/goals/#{Goal.find_by(body: "Goal body test").id}"
    expect(page).to have_content "Goal body test"
  end


end

feature 'update a goal' do
end

feature 'delete  a goal' do
end
