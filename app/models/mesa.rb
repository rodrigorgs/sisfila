class Mesa < ApplicationRecord
  belongs_to :aluno, required: false

  def self.associa_aluno_a_mesa(aluno, id_mesa)
    mesa_atual = Mesa.find_by id: id_mesa
    if mesa_atual
      mesa_atual.update(aluno: aluno)
    end
  end
end
