class Aluno < ApplicationRecord
  validates_uniqueness_of :matricula
  has_one :mesa
  has_and_belongs_to_many :grupos
end
