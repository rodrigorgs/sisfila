class ChangePosicaoToInteger < ActiveRecord::Migration[5.2]
  def change
    change_column :vagas, :posicao, :integer
  end
end
