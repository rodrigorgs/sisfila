class AddAtivoToAluno < ActiveRecord::Migration[5.2]
  def change
    add_column :alunos, :ativo, :boolean, default: true
  end
end
