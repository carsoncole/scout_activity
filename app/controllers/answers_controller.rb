class AnswersController < ApplicationController
  before_action :get_activity
  before_action :get_question

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to unit_activity_path(@unit, @activity), notice: 'Your answer has been posted.'
    else
      render :new
    end
  end

  def destroy
    answer = @question.answers.find(params[:id])
    answer.destroy if @activity.author == current_user || answer.user == current_user
    redirect_to unit_activity_path(@unit, @activity)
  end

  private

  def get_activity
    @activity = Activity.find(params[:activity_id])
  end

  def get_question
    @question = @activity.questions.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:content)
  end
end
