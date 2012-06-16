class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name,         :limit => 64,      :null => false
      t.string :abbreviation, :limit => 16,      :null => false
      t.string :state,        :limit => 4,       :null => false
      t.boolean :active,      :default => false, :null => false

      t.timestamps
    end

    add_index :cities, :name
    add_index :cities, :abbreviation
    add_index :cities, :state
    add_index :cities, :active

    # City.create(:name => 'San Francisco', :abbreviation => 'SF', :state => 'CA', :active => true)
    # City.create(:name => 'Boston', :abbreviation => 'BOS', :state => 'MA', :active => true)
  end
end
