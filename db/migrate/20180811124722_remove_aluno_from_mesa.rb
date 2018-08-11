class RemoveAlunoFromMesa < ActiveRecord::Migration[5.2]
  def change
    remove_column :mesas, :aluno, :reference
  end
end
