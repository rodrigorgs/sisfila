class Vaga < ApplicationRecord
  belongs_to :aluno
  belongs_to :rodada, required: false # TODO: remover esta associação
  belongs_to :fila, required: true
  acts_as_list scope: :fila, column: :posicao

  def codigo
    "#{self.fila.codigo}#{self.posicao}"
  end

  def title
    "#{self.codigo}"
  end
end
