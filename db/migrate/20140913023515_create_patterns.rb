class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.string :pattern
    end
  end
end
