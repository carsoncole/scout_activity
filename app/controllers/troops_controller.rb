class TroopsController < ApplicationController
  before_action :set_troop, only: [:show, :edit, :update, :destroy]

  # GET /troops
  # GET /troops.json
  def index
    @troops = Troop.all
  end

  # GET /troops/1
  # GET /troops/1.json
  def show
  end

  # GET /troops/new
  def new
    @troop = Troop.new
  end

  # GET /troops/1/edit
  def edit
  end

  # POST /troops
  # POST /troops.json
  def create
    @troop = Troop.new(troop_params)

    respond_to do |format|
      if @troop.save
        format.html { redirect_to @troop, notice: 'Troop was successfully created.' }
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
        format.html { redirect_to @troop, notice: 'Troop was successfully updated.' }
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
    def set_troop
      @troop = Troop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def troop_params
      params.require(:troop).permit(:unit_number)
    end
end
