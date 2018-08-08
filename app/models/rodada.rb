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

  # Retorna a primeira posição do aluno na fila a partir da posicao_atual.
  # Se o aluno não estiver na fila a partir da posicao_atual, retorna nil
  def posicao_aluno(aluno)
    vagas = Vaga.where("posicao >= ?", self.posicao_atual).where(aluno: aluno).order(posicao: :asc).limit(1)
    vagas && vagas.size >= 1 ? vagas[0].posicao - self.posicao_atual : nil
  end


end
