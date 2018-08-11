class AddAtivoToGrupo < ActiveRecord::Migration[5.2]
  def change
    add_column :grupos, :ativo, :boolean, default: true
  end
end
