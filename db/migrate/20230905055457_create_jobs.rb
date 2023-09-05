class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :job_title
      t.string :company_name
      t.string :job_category
      t.text :job_description
      t.decimal :salary
      t.text :location
      t.integer :post
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
