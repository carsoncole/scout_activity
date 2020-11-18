require 'application_system_test_case'

class DiscussionTest < ApplicationSystemTestCase
  def setup
    @activity = create(:activity)
    @unit = @activity.unit
    @user = create(:user, unit: @unit)
  end

  test 'unit user creating a question' do
    sign_in(@user)
    visit unit_activity_path(@unit, @activity)
    assert_selector 'h2', text: 'Discussion'
    assert_equal 0, @activity.questions.count
    click_on 'question-link'
    fill_in 'Enter your question or comment', with: 'What time do we leave?'
    click_on 'Ask your question or comment'
    assert_equal 1, @activity.questions.count
  end

  test 'public user signing in to create a question' do
    visit unit_activity_path(@unit, @activity)
    assert_selector 'h2', text: 'Discussion'
    has_link? 'Sign in to ask questions/comments'
    click_on 'Sign in to ask questions/comments'
    within '#clearance.sign-in' do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_on 'Sign in'
    end

    visit unit_activity_path(@unit, @activity)
    assert_selector 'h2', text: 'Discussion'

    assert_equal 0, @activity.questions.count
    assert_no_text 'Enter your answer'
    click_on 'question-link'
    fill_in 'Enter your question or comment', with: 'Should we bring food?'
    click_on 'Ask your question or comment'
    assert_text 'Should we bring food?'
    assert_text 'Add answer/comment'
  end

  test 'creating a question without a question' do
    user_2 = create(:user, unit: @unit)
    sign_in(user_2)
    visit unit_activity_path(@unit, @activity)
    click_on 'question-link'
    fill_in 'Enter your question or comment', with: ''
    click_on 'Ask your question or comment'
    assert_equal 0, @activity.questions.count
    assert_selector 'h1', text: 'Ask a Question'
  end

  test 'non unit user viewing a discussion' do
    user_2 = create(:user)
    sign_in(user_2)
    visit unit_activity_path(@unit, @activity)
    assert_selector 'h2', text: 'Discussion'
    has_no_link? 'Sign in to ask questions/comments'
    has_no_link? 'Question, comment?'
  end

  test 'destroying a question' do
    sign_in(@user)
    question = create(:question, activity: @activity, user: @user)
    visit unit_activity_path(@unit, @activity)
    click_on "question-#{question.id}-destroy-link"
    assert_equal 0, @activity.questions.count
  end

  test 'creating and destroying answer' do
    sign_in(@user)
    question = create(:question, activity: @activity, user: @user)
    visit unit_activity_path(@unit, @activity)
    click_on "question-#{question.id}-add-answer-link"
    fill_in 'Enter your answer', with: Faker::Lorem.sentence(word_count: 5)
    click_on 'Add your answer'
    assert_equal 1, question.answers.count

    click_on "answer-#{question.answers.first.id}-destroy-link"
    assert_equal 0, question.reload.answers.count
  end
end
