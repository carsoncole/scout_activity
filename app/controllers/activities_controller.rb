class ActivitiesController < ApplicationController
  include ActivitiesHelper

  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:create, :update, :destroy, :copy]
  before_action :require_unit_user, except: [:index, :show, :copy, :ideas_for_troop_activities, :ideas_for_covid_safe_troop_activities]
  before_action :require_author_admin_owner, only: [:edit, :update, :destroy]
  before_action :set_title, except: [:ideas_for_troop_activities, :ideas_for_covid_safe_troop_activities]

  def index
    @activities = @unit.activities.non_high_adventure.votable.order(votes_count: :desc)
    @high_adventure_activities  = @unit.activities.high_adventure.votable.order(votes_count: :desc)
    if signed_in? && current_user.admin_or_owner? && current_user.unit == @unit
      @archived_activities = @unit.activities.archived if current_user.admin_or_owner? && current_user.unit == @unit
    elsif signed_in? && current_user.activities.where(unit_id: @unit.id).archived.any?
      @archived_activities = current_user.activities.where(unit_id: @unit.id).archived
    end
    if @activities.any? && !@unit.is_example
      @description = "Vote now for your favorite #{@unit.name} activities that you'd like to see happen. There are currently #{@unit.activities.count} activities. The Unit will consider the vote tally in determining which activites they schedule."
    else
      @description = "Add your ideas to #{@unit.name}'s list of activities that the Unit's Scouts can vote on. They are looking for exciting activities to engage and excite them."
    end
    @title = "Activity Vote - ScoutActivity"
    @title = @unit.name + " - " + @title unless @unit.is_example?
    if signed_in? && current_user.unit.nil?
      flash[:alert] = "To vote, select a Unit in your <a href='/users/#{current_user.id}/edit'>Profile</a> settings."
    end
  end

  def show
    unit = @activity.unit
    @is_example = true if unit.is_example
    @votes = @activity.votes.includes(:user).group(:user_id).count
    @title = activity_page_title(@activity)
    unit.increment!(:visit_event_count)
    @questions = @activity.questions
    if @is_example
      @description = @activity.name + " is an idea for a Troop activity. "
    else
      @description = @activity.name + " is a proposed activity by #{unit.name}."
    end
    @description += @activity.summary_new || ""
    @description += "Will include the following: " + @activity.types.join(", ") if @activity.types.any?
    @description += " This activity also has been tagged with the following categories: " + @activity.categories.join(", ") + '.' if @activity.categories.any?
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
    if new_activity.save
      activity.increment!(:copy_count)
      activity.images.each do |image|
        new_activity.images.attach image.blob
      end
      redirect_back(fallback_location: unit_activities_path(current_user.unit), notice: "'#{new_activity.name}' copied to your Unit.")
    else
      Bugsnag.notify(new_activity) rescue nil
      redirect_to unit_activities_path(current_user.unit), alert: "There was a problem. The activity '#{new_activity.name}' was not copied to your Unit."
    end
  end

  def new
    @activity = Activity.new
    @title = @unit.name + ' - New Activity - ScoutActivity'
    @description = "Propose and activity for #{@unit.name} that Scouts can vote on as an activity to do."
  end

  def edit
    @title = activity_page_title(@activity)
  end

  def create
    @activity = @unit.activities.new(activity_params)
    @activity.author = current_user

    if @activity.save
      redirect_to unit_activities_path(@unit), notice: 'Activity was successfully created.'
    else
      render :new
    end
  end

  def update
    if @activity.update(activity_params)
      redirect_to unit_activity_path(@unit, @activity), notice: 'Activity was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @activity.destroy
    redirect_to unit_activities_url(@unit), notice: 'Activity was successfully destroyed.'
  end

  def ideas_for_troop_activities
    @activities = Unit.example.first.activities.troop
    @activities_count = @activities.count
    @title = @activities.count.to_s + ' Ideas for Troop Activities - ScoutActivity'
    @no_vote = true
    @description = "List of curated ideas for Scout Troop activiities. Ideas ranging from simple competitions, to multi-day events."
    if params[:filter]
      @activities = @activities.where(params[:filter])
    end
  end

  def ideas_for_covid_safe_troop_activities
    @activities = Unit.example.first.activities.troop.where(is_covid_safe: true)
    @activities_count = @activities.count
    @title = @activities.count.to_s + ' COVID Safe Ideas for Troop Activities - ScoutActivity'
    @no_vote = true
    @description = "List of curated COVID safe ideas for Scout Troop activiities, including both virtual and in-person activities."
    if params[:filter]
      @activities = @activities.where(params[:filter])
    end
  end

  private

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
    if @unit
      @title = @unit.name + ' - Activities - ScoutActivity'
    else
      @title = @activity.unit.name + ' - Activities - ScoutActivity'
    end
  end
  # Only allow a list of trusted parameters through.
  def activity_params
    params.require(:activity).permit(:name, :author, :summary, :itinerary, :description, :duration_days, :is_high_adventure, :is_author_volunteering, :is_hiking, :is_camping, :is_plane, :is_virtual, :is_swimming, :is_community_service, :is_archived, :is_biking, :is_cooking, :is_boating, :is_covid_safe, :is_game, :is_fundraising, :is_merit_badge, :is_international, :summary_new, :is_troop, :is_pack, images: [])
  end
end
