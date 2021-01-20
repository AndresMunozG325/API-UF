class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.date :r_date
      t.string :v_uf

      t.timestamps
    end
  end
end
