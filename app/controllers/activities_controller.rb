class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:create, :update, :destroy, :copy]
  before_action :set_title

  def index
    @activities = @unit.activities.non_high_adventure.votable.order(votes_count: :desc)
    @high_adventure_activities  = @unit.activities.high_adventure.votable.order(votes_count: :desc)
    if signed_in? && current_user.is_owner? && current_user.unit == @unit
      @archived_activities = @unit.activities.archived if current_user.is_owner? && current_user.unit == @unit
    elsif signed_in? && current_user.activities.where(unit_id: @unit.id).archived.any?
      @archived_activities = current_user.activities.where(unit_id: @unit.id).archived
    end
    @title = @unit.name + " - Vote - ScoutActivity"
  end

  def show
    @votes = @activity.votes.includes(:user).group(:user_id).count
    @title = "#{@unit.name} - #{@activity.name} - ScoutActivity"
    @unit.increment!(:visit_event_count)
    @questions = @activity.questions
  end

  def archive_activity
    @activity = @unit.activities.find(params[:activity_id])
    @activity.toggle!(:is_archived)
    redirect_to unit_activity_path(@unit, @activity)
  end

  def copy
    activity = Activity.find(params[:activity_id])
    new_activity = Activity.duplicate(activity)
    new_activity.author_id = current_user.id
    new_activity.unit = current_user.unit
    new_activity.save
    redirect_to unit_activities_path(current_user.unit), notice: "Activity '#{new_activity.name}' copied."
  end

  def new
    @activity = Activity.new
    @title = @unit.name + ' - New Activity - ScoutActivity'
  end

  def edit
    @title = @unit.name + ' - Edit ' + @activity.name +  ' - ScoutActivity'
  end

  def create
    @activity = @unit.activities.new(activity_params)
    @activity.author = current_user

    respond_to do |format|
      if @activity.save
        format.html { redirect_to unit_activities_path(@unit), notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @activity.author == current_user && @activity.update(activity_params)
        format.html { redirect_to unit_activity_path(@unit, @activity), notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity.destroy if @activity.author == current_user
    respond_to do |format|
      format.html { redirect_to unit_activities_url(@unit), notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def set_title
      @title = @unit.name + ' - Activities - ScoutActivity'
    end
    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :author, :summary, :itinerary, :description, :duration_days, :is_high_adventure, :is_author_volunteering, :is_hiking, :is_camping, :is_plane, :is_virtual, :is_swimming, :is_community_service, :is_archived, :is_biking, :is_cooking, :is_game, :is_fundraising, :is_merit_badge, :is_international, images: [])
    end
end
