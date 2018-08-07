class Rodada < ApplicationRecord
  def aluno_atual
    Aluno.find_by id: self.posicao_atual
  end
end
