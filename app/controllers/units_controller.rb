class UnitsController < ApplicationController
  before_action :require_login
  before_action :get_unit, only: [:edit, :update]
  before_action :require_admin_owner_login, only: [:edit, :update]
  before_action :set_title

  def new
    @unit = Unit.new
    @title = "New Unit - ScoutActivity"
  end

  def edit
    @users = @unit.users
    @title = "Unit info - #{@unit.name} - ScoutActivity"
  end

  def unit_created
    @title = 'Unit Created - ' + @unit.name + ' - ScoutActivity'
  end

  def create
    @unit = Unit.new(unit_params)

    respond_to do |format|
      if @unit.save
        current_user.update(unit_id: @unit.id, is_owner: true)
        format.html { redirect_to unit_activities_path(@unit), notice: 'Unit was successfully created.' }
        format.json { render :show, status: :created, location: @unit }
      else
        format.html { render :new }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @unit.update(unit_params)
        format.html { redirect_to unit_activities_path(@unit), notice: 'Unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit }
      else
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # @unit.destroy
    # respond_to do |format|
    #   format.html { redirect_to units_url, notice: 'Unit was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_unit
      @unit = Unit.friendly.find(params[:id])
    end

    def set_title
      @title = 'Unit - ScoutActivity'
    end

    # Only allow a list of trusted parameters through.
    def unit_params
      params.require(:unit).permit(:name, :votes_allowed)
    end
end
