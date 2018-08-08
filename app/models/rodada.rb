class Rodada < ApplicationRecord
  has_many :vagas, -> { order(posicao: :asc) }

  def aluno_atual
    aluno = nil
    vaga = Vaga.find_by posicao: self.posicao_atual
    if vaga
      aluno = vaga.aluno
    end
    aluno
  end

  def proximos(n)
    Vaga.where("posicao > ?", self.posicao_atual).order(posicao: :asc).limit(n)
  end

end
