#coding: utf-8
class Datanest::Consolidation < Datanest::Basis
  csv           'konsolidacna-dump.csv'
  display_name  'Slovenská konsolidačná'

  def address
    "#{psc} #{city}"
  end

  def year
    updated_at.year
  end

  def profit
    amount
  end

end
