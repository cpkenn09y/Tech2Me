require 'spec_helper'

feature "Questions" do

  let(:my_question) {
      Question.create(title: "Is this a valid question?", body: "let's take this question seriously.")
  }

  scenario "User visits questions index and it should display a list of question titles" do
    Question.create(title: "Burger King", body: "can you flip a burger?")
    visit questions_path
    expect(page).to have_content("Burger King")
  end

  scenario "User can get to new questions form via questions#index" do
    visit questions_path
    click_link "New Question"
    expect(page).to have_css("form#new_question")
  end

  scenario "User can create a new question" do
    sign_in_user
    visit new_question_path
    title = "APPLES"
    fill_in 'Title', :with => title
    fill_in 'Question', :with => "Sauce"
    click_button 'Ask dat question'
    expect(page).to have_content(title)
  end

  scenario "Users should be able to visit the question show page" do
    visit question_path(my_question)
    page.should have_content('Add a new answer')
  end

  context "User visits questions index" do
    it "should display a list of question titles" do
      Question.create(title: "Burger King", body: "can you flip a burger?")
      visit questions_path
      expect(page).to have_content("Burger King")
    end
  end

  context "User clicks 'New Question' button", js: true do
    it "should display a pop up form" do
      visit questions_path
      click_on 'New Question'
      expect(page).to have_content("Ask a Question:")
    end
  end

  context "question#show" do

    it "should have an edit button" do
      question = Question.create(title: "Burger King", body: "can you flip a burger?")
      visit question_path(question)
      expect(page).to have_content('edit')
    end

    it "should display an edit form when edit is clicked" do
      question = Question.create(title: "Burger King", body: "can you flip a burger?")
      visit question_path(question)
      click_on "edit"
      page.has_selector?('form')
    end
  end
end