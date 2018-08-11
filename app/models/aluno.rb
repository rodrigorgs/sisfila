class Aluno < ApplicationRecord
  validates_uniqueness_of :matricula
  has_one :mesa
  has_and_belongs_to_many :grupos

  def esta_em_algum_grupo
    self.grupos.where(ativo: true).order(prioridade: :asc).first != nil
  end

  # def primeiro_grupo_ativo
  #   self.grupos.where(ativo: true).order(prioridade: :asc).first
  # end

  # TODO: primeiro_grupo_ativo_com_fila_ativa
  def primeiro_grupo_ativo_com_fila
    self.grupos.where(ativo: true).where.not(fila: nil).order(prioridade: :asc).first
  end
end
