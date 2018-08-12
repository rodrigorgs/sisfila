class MesasController < ApplicationController
  before_action :set_mesa, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /mesas
  # GET /mesas.json
  def index
    @mesas = Mesa.all
    @mesa_atual = Mesa.find_by id: session[:mesa] if session[:mesa]
  end

  # GET /mesas/1
  # GET /mesas/1.json
  def show
  end

  # GET /mesas/new
  def new
    @mesa = Mesa.new
  end

  # GET /mesas/1/edit
  def edit
  end

  def escolher
    session[:mesa] = params[:id]
    redirect_to mesas_path
  end

  # POST /mesas
  # POST /mesas.json
  def create
    @mesa = Mesa.new(mesa_params)

    respond_to do |format|
      if @mesa.save
        format.html { redirect_to @mesa, notice: 'Mesa was successfully created.' }
        format.json { render :show, status: :created, location: @mesa }
      else
        format.html { render :new }
        format.json { render json: @mesa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mesas/1
  # PATCH/PUT /mesas/1.json
  def update
    respond_to do |format|
      if @mesa.update(mesa_params)
        format.html { redirect_to @mesa, notice: 'Mesa was successfully updated.' }
        format.json { render :show, status: :ok, location: @mesa }
      else
        format.html { render :edit }
        format.json { render json: @mesa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mesas/1
  # DELETE /mesas/1.json
  def destroy
    @mesa.destroy
    respond_to do |format|
      format.html { redirect_to mesas_url, notice: 'Mesa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mesa
      @mesa = Mesa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mesa_params
      params.require(:mesa).permit(:nome, :ativo, :aluno_id)
    end
end
