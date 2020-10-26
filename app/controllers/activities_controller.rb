class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:create, :update, :destroy]
  before_action :set_title

  # GET /activities
  # GET /activities.json
  def index
    if params[:admin] && current_user == @troop.owner
      @activities = @troop.activities
    elsif params[:admin]
      @activities = current_user.activities
    else
      @activities = @troop.activities.non_high_adventure.votable.order(votes_count: :desc)
      @high_adventure_activities  = @troop.activities.high_adventure.votable.order(votes_count: :desc)
    end
    @title = @troop.unit_name + " - Activities - ScoutActivity"
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @votes = @activity.votes.includes(:user).group(:user_id).count
    @title = "#{@troop.unit_name} - #{@activity.name} - ScoutActivity"
  end

  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = @troop.activities.new(activity_params)
    @activity.author = current_user

    respond_to do |format|
      if @activity.save
        format.html { redirect_to troop_activities_path(@troop), notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.author == current_user && @activity.update(activity_params)
        format.html { redirect_to troop_activity_path(@troop, @activity), notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy if @activity.author == current_user
    respond_to do |format|
      format.html { redirect_to troop_activities_url(@troop), notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def set_title
      @title = 'Activities | ScoutActivity'
    end
    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :author, :summary, :itinerary, :description, :duration_days, :is_high_adventure, :is_author_volunteering, :is_hiking, :is_camping, :is_plane, :is_swimming, :is_community_service, :is_archived, :is_biking, images: [])
    end
end
