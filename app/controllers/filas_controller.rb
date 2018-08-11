class FilasController < ApplicationController
  before_action :set_fila, only: [:show, :edit, :update, :destroy]

  # GET /filas
  # GET /filas.json
  def index
    @filas = Fila.all
  end

  # GET /filas/1
  # GET /filas/1.json
  def show
  end

  # GET /filas/new
  def new
    @fila = Fila.new
  end

  # GET /filas/1/edit
  def edit
  end

  # POST /filas
  # POST /filas.json
  def create
    @fila = Fila.new(fila_params)

    respond_to do |format|
      if @fila.save
        format.html { redirect_to @fila, notice: 'Fila was successfully created.' }
        format.json { render :show, status: :created, location: @fila }
      else
        format.html { render :new }
        format.json { render json: @fila.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filas/1
  # PATCH/PUT /filas/1.json
  def update
    respond_to do |format|
      if @fila.update(fila_params)
        format.html { redirect_to @fila, notice: 'Fila was successfully updated.' }
        format.json { render :show, status: :ok, location: @fila }
      else
        format.html { render :edit }
        format.json { render json: @fila.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filas/1
  # DELETE /filas/1.json
  def destroy
    @fila.destroy
    respond_to do |format|
      format.html { redirect_to filas_url, notice: 'Fila was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fila
      @fila = Fila.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fila_params
      params.require(:fila).permit(:codigo, :nome, :prioridade, :ativo)
    end
end
