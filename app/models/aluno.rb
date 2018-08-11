class Aluno < ApplicationRecord
  validates_uniqueness_of :matricula
  has_one :mesa
end
