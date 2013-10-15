class CreateStartups < ActiveRecord::Migration
  def change
    create_table :startups do |t|
      t.string :name
      t.string :logo_url
      t.string :location
      t.text :product_desc
      t.string :high_concept
      t.string :pitch
      t.string :company_url

      t.timestamps
    end
  end
end
