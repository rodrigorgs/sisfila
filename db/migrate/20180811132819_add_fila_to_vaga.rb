class AddFilaToVaga < ActiveRecord::Migration[5.2]
  def change
    add_reference :vagas, :fila, foreign_key: true
  end
end
