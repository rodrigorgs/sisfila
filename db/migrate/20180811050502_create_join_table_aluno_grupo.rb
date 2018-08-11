class CreateJoinTableAlunoGrupo < ActiveRecord::Migration[5.2]
  def change
    create_join_table :alunos, :grupos do |t|
      t.index [:aluno_id, :grupo_id]
    end
  end
end
