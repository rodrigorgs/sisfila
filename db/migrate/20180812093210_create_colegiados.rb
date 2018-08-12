class CreateColegiados < ActiveRecord::Migration[5.2]
  def change
    create_table :colegiados do |t|
      t.string :nome
      t.string :codigo

      t.timestamps
    end
  end
end
