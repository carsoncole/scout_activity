class UnitVotesController < ApplicationController
  def index; end

  def create
    unit = Unit.friendly.find(params[:unit_id])
    @vote = UnitVote.create(activity_id: params[:activity_id], user: current_user, unit: unit)
    puts @vote.inspect
    puts @vote.errors.full_messages
    redirect_to unit_activities_path(@unit)
  end

  def destroy
    @vote = begin
      UnitVote.find(params[:id])
    rescue StandardError
      nil
    end
    @vote&.destroy
    redirect_to unit_activities_path(@unit)
  end

  def unit_vote_params
    params.require(:unit_vote).permit(:unit_id, :activity_id)
  end
end
