class AddInscricaoGuestToRodada < ActiveRecord::Migration[5.2]
  def change
    add_column :rodadas, :inscricao_guest, :boolean
  end
end
