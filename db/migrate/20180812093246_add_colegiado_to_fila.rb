class AddColegiadoToFila < ActiveRecord::Migration[5.2]
  def change
    add_reference :filas, :colegiado, foreign_key: true
  end
end
