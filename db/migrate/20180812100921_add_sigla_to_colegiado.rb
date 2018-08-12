class AddSiglaToColegiado < ActiveRecord::Migration[5.2]
  def change
    add_column :colegiados, :sigla, :string
  end
end
