class Vaga < ApplicationRecord
  belongs_to :aluno
  belongs_to :rodada
  acts_as_list scope: :rodada, column: :posicao
end
