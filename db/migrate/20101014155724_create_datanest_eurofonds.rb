class CreateDatanestEurofonds < ActiveRecord::Migration
  def self.up
    create_table :datanest_eurofonds do |t|
      t.string :title, :limit => 50
      t.string :name, :limit => 100
      t.string :surname, :limit => 100
      t.string :company, :limit => 200
      t.string :ico, :limit => 50
      t.string :address, :limit => 200
      t.string :city, :limit => 100
      t.string :zip, :limit => 40
      t.float :requested_amount
      t.float :grant_amount
      t.float :accepted_amount
      t.float :own_resources_amount
      t.float :budget
      t.string :conditions_fullfilment, :limit => 500
      t.float :paid_amount
      t.float :used_amount
      t.string :currency, :limit => 5
      t.float :receiver_share_amount
      t.string :dotation_provider, :limit => 200
      t.string :via, :limit => 200
      t.string :resort, :limit => 200
      t.date   :commitee_meeting_at
      t.date   :request_accepted_at
      t.date   :decided_at
      t.date   :granted_at
      t.string :registration_number, :limit => 100
      t.string :purpose, :limit => 500
      t.string :source, :limit => 500
      t.string :program, :limit => 500
      t.string :dotation_type, :limit => 500
      t.string :fund_name, :limit => 500
      t.string :decision_number, :limit => 100
      t.string :region, :limit => 100
      t.string :note, :limit => 500
      t.string :additional_note, :limit => 500
      t.integer :year
      t.date   :project_start_at
      t.date   :project_finish_at
    end
  end

  def self.down
    drop_table :datanest_eurofonds
  end
end
