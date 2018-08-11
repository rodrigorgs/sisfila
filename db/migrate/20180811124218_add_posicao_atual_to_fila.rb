class AddPosicaoAtualToFila < ActiveRecord::Migration[5.2]
  def change
    add_column :filas, :posicao, :integer, default: 1, null: false
  end
end
