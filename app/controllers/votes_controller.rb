class VotesController < ApplicationController
  def index
  end

  def create
    @vote = Vote.create(activity_id: params[:activity_id], user: current_user)
    puts @vote.errors.full_messages
    redirect_to unit_activities_path(@unit)
  end

  def destroy
    @vote = Vote.find(params[:id]) rescue nil
    @vote.destroy if @vote
    redirect_to unit_activities_path(@unit)
  end
end
