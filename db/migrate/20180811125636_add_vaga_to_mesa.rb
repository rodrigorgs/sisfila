class AddVagaToMesa < ActiveRecord::Migration[5.2]
  def change
    add_reference :mesas, :vaga, foreign_key: true
  end
end
