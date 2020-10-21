class VotesController < ApplicationController
  def index
  end

  def create
    @vote = Vote.create(activity_id: params[:activity_id], user: @user)
    puts @vote.errors.full_messages
    redirect_to troop_activities_path(@troop)
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy if @vote
    redirect_to troop_activities_path(@troop)
  end
end
