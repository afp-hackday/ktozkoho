class Connection < ActiveRecord::Base
  belongs_to :subject
  belongs_to :connected_subject, :class_name => 'Subject', :foreign_key => :connected_subject_id

  validates_presence_of :subject, :connected_subject

  after_save :sync_reverse_connection

  private
  def sync_reverse_connection
    Connection.find_or_create_by_subject_id_and_connected_subject_id(connected_subject.id, subject.id)
  end
end

