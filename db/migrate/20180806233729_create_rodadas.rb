class CreateRodadas < ActiveRecord::Migration[5.2]
  def change
    create_table :rodadas do |t|
      t.string :descricao
      t.integer :posicao_atual

      t.timestamps
    end
  end
end
