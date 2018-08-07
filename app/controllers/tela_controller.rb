class TelaController < ApplicationController
  def index
    @rodada = Rodada.first
  end
end
