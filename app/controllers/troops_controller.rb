class TroopsController < ApplicationController
  before_action :get_troop, only: [:show, :edit, :update, :destroy]
  before_action :set_title

  # GET /troops/new
  def new
    @troop = Troop.new
  end

  # GET /troops/1/edit
  def edit
    redirect_to troop_activities_path(@troop) unless current_user.troop == @troop && current_user.is_owner?
  end

  def troop_created
    @title = 'Troop Created - ' + @troop.name + ' - ScoutActivity'
  end

  # POST /troops
  # POST /troops.json
  def create
    @troop = Troop.new(troop_params)

    respond_to do |format|
      if @troop.save
        current_user.update(troop_id: @troop.id, is_owner: true)
        format.html { redirect_to root_path, notice: 'Troop was successfully created.' }
        format.json { render :show, status: :created, location: @troop }
      else
        format.html { render :new }
        format.json { render json: @troop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /troops/1
  # PATCH/PUT /troops/1.json
  def update
    respond_to do |format|
      if @troop.update(troop_params)
        format.html { redirect_to root_path, notice: 'Troop was successfully updated.' }
        format.json { render :show, status: :ok, location: @troop }
      else
        format.html { render :edit }
        format.json { render json: @troop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /troops/1
  # DELETE /troops/1.json
  def destroy
    @troop.destroy
    respond_to do |format|
      format.html { redirect_to troops_url, notice: 'Troop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_troop
      @troop = Troop.friendly.find(params[:id])
    end

    def set_title
      @title = 'Troop | ScoutActivity'
    end

    # Only allow a list of trusted parameters through.
    def troop_params
      params.require(:troop).permit(:name, :votes_allowed)
    end
end
