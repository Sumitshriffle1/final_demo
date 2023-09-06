class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :image
      t.string :skills
      t.string :education
      t.text :experience
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
