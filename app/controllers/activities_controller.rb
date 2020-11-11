class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:create, :update, :destroy, :copy]
  before_action :require_unit_user, except: [:index, :show, :copy]
  before_action :require_author_admin_owner, only: [:edit, :update, :destroy]
  before_action :set_title

  def index
    @activities = @unit.activities.non_high_adventure.votable.order(votes_count: :desc)
    @high_adventure_activities  = @unit.activities.high_adventure.votable.order(votes_count: :desc)
    if signed_in? && current_user.admin_or_owner? && current_user.unit == @unit
      @archived_activities = @unit.activities.archived if current_user.admin_or_owner? && current_user.unit == @unit
    elsif signed_in? && current_user.activities.where(unit_id: @unit.id).archived.any?
      @archived_activities = current_user.activities.where(unit_id: @unit.id).archived
    end
    if @activities.any?
      @description = "Vote now for your favorite #{@unit.name} activities that you'd like to see happen. There are currently #{@unit.activities.count} activities. The Unit will consider the vote tally in determining which activites they schedule."
    else
      @description = "Add your ideas to #{@unit.name}'s list of activities that the Unit's Scouts can vote on. They are looking for exciting activities to engage and excite them."
    end

    @description = 'View this example Unit for ideas that can be copied to your own Unit.' if @unit.is_example
    @title = @unit.name + " - Activity Vote - ScoutActivity"
    if signed_in? && current_user.unit.nil?
      flash[:alert] = "To vote, select a Unit in your <a href='/users/#{current_user.id}/edit'>Profile</a> settings."
    end
  end

  def show
    @votes = @activity.votes.includes(:user).group(:user_id).count
    @title = "#{@unit.name} - #{@activity.name} - ScoutActivity"
    @unit.increment!(:visit_event_count)
    @questions = @activity.questions
    @description = "Activity proposed: " +  @activity.name
  end

  def archive_activity
    @activity = @unit.activities.find(params[:activity_id])
    @activity.toggle!(:is_archived)
    if @activity.is_archived
      message = 'Activity is archived, and no longer in the activity voting list.'
    else
      message = 'Activity is unarchived and showing in the activity voting list.'
    end
    redirect_to unit_activity_path(@unit, @activity), notice: message
  end

  def copy
    activity = Activity.find(params[:activity_id])
    new_activity = Activity.duplicate(activity)
    new_activity.author_id = current_user.id
    new_activity.unit = current_user.unit
    new_activity.save
    activity.images.each do |image|
      new_activity.images.attach image.blob
    end
    redirect_to unit_activities_path(current_user.unit), notice: "Activity '#{new_activity.name}' copied to your Unit."
  end

  def new
    @activity = Activity.new
    @title = @unit.name + ' - New Activity - ScoutActivity'
    @description = "Propose and activity for #{@unit.name} that Scouts can vote on as an activity to do."
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
      if @activity.update(activity_params)
        format.html { redirect_to unit_activity_path(@unit, @activity), notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to unit_activities_url(@unit), notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def require_unit_user
      redirect_to root_path unless signed_in? && current_user.unit == @unit
    end

    def require_author_admin_owner
      redirect_to root_path unless signed_in? && (@activity.author == current_user || current_user.admin_or_owner?)
    end

    def set_activity
      @activity = Activity.find(params[:id])
    end

    def set_title
      @title = @unit.name + ' - Activities - ScoutActivity'
    end
    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :author, :summary, :itinerary, :description, :duration_days, :is_high_adventure, :is_author_volunteering, :is_hiking, :is_camping, :is_plane, :is_virtual, :is_swimming, :is_community_service, :is_archived, :is_biking, :is_cooking, :is_boating, :is_game, :is_fundraising, :is_merit_badge, :is_international, :summary_new, images: [])
    end
end
