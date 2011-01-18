class CreateAdvantages < ActiveRecord::Migration
  def self.up
    create_table :advantages do |t|
      t.float :profit
      t.integer :year
      t.references :subject
      t.string :type
    end
    add_index :advantages, :subject_id
  end

  def self.down
    drop_table :advantages
  end
end
