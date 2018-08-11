class AddScoreAndPreMatriculaAndFormandoToAluno < ActiveRecord::Migration[5.2]
  def change
    add_column :alunos, :score, :integer
    add_column :alunos, :fezPreMatricula, :boolean, default: false
    add_column :alunos, :formando, :boolean, default: false
  end
end
