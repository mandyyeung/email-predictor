class CreateDomainPatterns < ActiveRecord::Migration
  def change
    create_table :domain_patterns do |t|
      t.belongs_to :domain
      t.belongs_to :pattern
    end
  end
end
