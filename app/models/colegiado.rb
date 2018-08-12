class Colegiado < ApplicationRecord
  has_many :alunos
  has_many :filas

  def title
    "#{self.nome}"
  end
end
