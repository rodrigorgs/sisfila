class Fila < ApplicationRecord
  acts_as_list column: :prioridade
  has_many :grupos
  has_many :vagas

  def vaga_atual
    self.vagas.find_by posicao: self.posicao
  end

  def chama_proximo(mesa_id, incremento=1)
    self.increment!(:posicao, incremento)
    Mesa.associa_vaga_a_mesa(self.vaga_atual, mesa_id)
  end
end
