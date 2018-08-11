class CreateFilas < ActiveRecord::Migration[5.2]
  def change
    create_table :filas do |t|
      t.string :codigo
      t.integer :prioridade
      t.boolean :ativo, default: true

      t.timestamps
    end
  end
end
