class AddNomeToFila < ActiveRecord::Migration[5.2]
  def change
    add_column :filas, :nome, :string
  end
end
