class Aluno < ApplicationRecord
  validates_uniqueness_of :matricula
  has_many :mesa
end
