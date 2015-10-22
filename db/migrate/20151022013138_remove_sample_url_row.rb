class RemoveSampleUrlRow < ActiveRecord::Migration
  def up
  	remove_column :tracks, :sample_url
  end
  def down
  	add_column :tracks, :sample_url, :string
  end
end
