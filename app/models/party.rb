class Party < ActiveRecord::Base
  has_many :party_loans, :class_name => "Datanest::PartyLoan"
  has_many :party_sponsors, :class_name => "Datanest::PartySponsor"

  has_many :loaning_subjects, :through => :party_loans, :class_name => 'Subject', :source => :subject
  has_many :sponsoring_subjects, :through => :party_sponsors, :class_name => 'Subject', :source => :subject

  def related_subjects
    loaning_subjects + sponsoring_subjects
  end

  def profits_of_related_subjects_per_year
    related_subjects.inject({}) do |profits, subject|
       profits.merge(subject.profits_per_year) do |key, summary, profit|
         summary + profit
       end
     end
  end

  def incomes
    party_sponsors.sum('amount')+party_loans.sum('amount')
  end

  def profits
    profits_of_related_subjects_per_year.values.inject(0) {|sum, value| sum + value}
  end

  def portfolio
    Advantage.where(:subject_id => related_subjects.collect(&:id)).group(:type).sum(:profit)
  end
end