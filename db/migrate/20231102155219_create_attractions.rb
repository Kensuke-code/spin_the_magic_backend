class CreateAttractions < ActiveRecord::Migration[7.1]
  def change
    create_table :attractions do |t|
      t.string :name
      t.string :scraping_name
      t.references :area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
