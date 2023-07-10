class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :tla
      t.string :short_name
      t.string :area_name
      t.string :address
      t.references :competition, foreign_key: true


      t.timestamps
    end
  end
end
