require 'test_helper'

class QuizAdministrationTest < ActionDispatch::IntegrationTest
  test 'unauthorised user cannot create an quiz' do
    visit root_path
    refute page.has_link?('new quiz', href: new_quiz_path)

    visit new_quiz_path
    assert_path signin_path
  end

  test 'authorised user can create an quiz' do
    login_as users(:admin)
    visit root_path
    click_link 'New quiz'

    fill_in :quiz_title, with: 'New quiz title'
    fill_in :quiz_description, with: 'Event description'
    click_on 'Save'

    last_quiz =  Quiz.last

    assert_equal 'New quiz title', last_quiz.title
  end

  test 're-render the page when creating invalid quizzes' do
    login_as users(:admin)
    visit root_path
    click_link 'New quiz'

    click_on 'Save'

    assert page.has_content?("Title can't be blank")
  end

  test 'unauthorised user cannot edit an quiz' do
    quiz = quizzes(:cryptographic_challenge)

    visit quiz_path(quiz)
    refute page.has_link?('Edit', href: edit_quiz_path(quiz))

    visit edit_quiz_path(quiz)
    assert_path signin_path
  end

  test 'authorised user can edit an quiz' do
    quiz = quizzes(:cryptographic_challenge)
    login_as users(:admin)
    visit quiz_path(quiz)
    click_link 'Edit'

    fill_in :quiz_title, with: 'Edited quiz title'
    fill_in :quiz_description, with: 'Edited event description'
    click_on 'Save'

    assert page.has_content?('Edited quiz title')
  end

  test 're-render the page when editing invalid quizzes' do
    quiz = quizzes(:cryptographic_challenge)
    login_as users(:admin)
    visit quiz_path(quiz)
    click_link 'Edit'

    fill_in :quiz_title, with: ''
    fill_in :quiz_description, with: ''
    click_on 'Save'

    assert page.has_content?("Title can't be blank")
  end
end
