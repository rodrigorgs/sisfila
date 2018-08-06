class CreateVagas < ActiveRecord::Migration[5.2]
  def change
    create_table :vagas do |t|
      t.references :aluno, foreign_key: true
      t.string :posicao
      t.datetime :data_chamada

      t.timestamps
    end
  end
end
