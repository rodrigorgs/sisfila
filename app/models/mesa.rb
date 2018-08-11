class Mesa < ApplicationRecord
  belongs_to :vaga, required: false

  def self.associa_vaga_a_mesa(vaga, id_mesa)
    mesa_atual = Mesa.find_by id: id_mesa
    if mesa_atual
      mesa_atual.update(vaga: vaga)
    end
  end

  def title
    "#{self.nome}"
  end
end
