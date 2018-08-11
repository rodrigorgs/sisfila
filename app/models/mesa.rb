class Mesa < ApplicationRecord
  belongs_to :aluno, required: false
end
