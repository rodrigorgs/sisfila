class Rodada < ApplicationRecord
  has_many :vagas, -> { order(posicao, :asc) }

  def aluno_atual
    Aluno.find_by id: self.posicao_atual
  end
end
