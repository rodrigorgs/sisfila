class AddRodadaToVagas < ActiveRecord::Migration[5.2]
  def change
    add_reference :vagas, :rodada, foreign_key: true
  end
end
