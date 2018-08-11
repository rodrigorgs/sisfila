class Aluno < ApplicationRecord
    validates_uniqueness_of :matricula
end
