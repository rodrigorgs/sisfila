class MakeMatriculaUnique < ActiveRecord::Migration[5.2]
  def change
    add_index :alunos, :matricula, unique: true
  end
end
