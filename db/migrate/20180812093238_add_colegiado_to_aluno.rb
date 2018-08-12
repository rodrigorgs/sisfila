class AddColegiadoToAluno < ActiveRecord::Migration[5.2]
  def change
    add_reference :alunos, :colegiado, foreign_key: true
  end
end
