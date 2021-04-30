class UnitsController < ApplicationController
  before_action :require_login
  before_action :require_admin_owner_login, only: %i[edit update]
  before_action :page_title

  def new
    @unit = Unit.new
    @title = 'New Unit - Scout Activity'
  end

  def edit
    @users = @unit.users
    @title = "Unit info - #{@unit.name} - Scout Activity"
  end

  def create
    @unit = Unit.new(unit_params)
    if @unit.save
      current_user.update(unit_id: @unit.id, is_owner: true)
      redirect_to unit_activities_path(@unit), notice: 'Unit was successfully created.'
    else
      render :new
    end
  end

  def update
    if @unit.update(unit_params)
      redirect_to unit_activities_path(@unit), notice: 'Unit was successfully updated.'
    else
      @users = @unit.users
      render :edit
    end
  end

  def destroy; end

  private

  def page_title
    @title = 'Unit - Scout Activity'
  end

  def unit_params
    params.require(:unit).permit(:name, :votes_allowed)
  end
end
