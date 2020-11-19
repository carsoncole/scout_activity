class QuestionsController < ApplicationController
  before_action :activity

  def index
    @questions = @activity.questions.include(:answers)
  end

  def show; end

  def edit; end

  def new
    @question = @activity.questions.new
  end

  def create
    @question = @activity.questions.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to unit_activity_path(@unit, @activity), notice: 'Your question has been posted.'
    else
      render :new
    end
  end

  def update; end

  def destroy
    question = @activity.questions.find(params[:id])
    question.destroy if @activity.author == current_user || question.user == current_user
    redirect_to unit_activity_path(@unit, @activity)
  end

  private

  def activity
    @activity = Activity.find(params[:activity_id])
  end

  def question_params
    params.require(:question).permit(:content)
  end
end
