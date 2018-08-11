class Fila < ApplicationRecord
  acts_as_list column: :prioridade
  has_many :grupos
end
