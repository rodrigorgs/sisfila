class AddFilaToGrupo < ActiveRecord::Migration[5.2]
  def change
    add_reference :grupos, :fila, foreign_key: true
  end
end
