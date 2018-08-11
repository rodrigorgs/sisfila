class CreateMesas < ActiveRecord::Migration[5.2]
  def change
    create_table :mesas do |t|
      t.string :nome
      t.boolean :ativo, default: true
      t.references :aluno, foreign_key: true, null: true

      t.timestamps
    end
  end
end
