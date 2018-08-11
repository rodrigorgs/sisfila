class Aluno < ApplicationRecord
  validates_uniqueness_of :matricula
  has_one :mesa
  has_and_belongs_to_many :grupos

  def primeiro_grupo_ativo
    self.first.grupos.where(ativo: true).order(prioridade: :asc).first
  end
end
