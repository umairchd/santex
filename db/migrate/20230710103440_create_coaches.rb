class CreateCoaches < ActiveRecord::Migration[7.0]
  def change
    create_table :coaches do |t|
      t.string :name
      t.string :date_of_birth
      t.string :nationality
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
