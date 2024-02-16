class Vaga < ApplicationRecord
  belongs_to :aluno
  belongs_to :rodada, required: false # TODO: remover esta associação
  belongs_to :fila, required: true
  has_one :mesa, dependent: :nullify
  acts_as_list scope: :fila, column: :posicao

  def codigo
    "#{self.fila&.codigo}_#{self.posicao}"
  end

  def title
    "[#{self.codigo}] #{self.aluno&.nome}"
  end
end
