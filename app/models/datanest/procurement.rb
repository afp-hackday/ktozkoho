#coding: utf-8
class Datanest::Procurement < Datanest::BaseAdvantage
  csv 'procurements_2-dump.csv'
  csv 'procurements-dump.csv',
        :year => 11,
        :bulletin_id => 12,
        :procurement_id => 13,
        :customer_ico => 20,
        :company => 19,
        :supplier_ico => 22,
        :supplier_company_name => 21,
        :supplier_region => 23,
        :procurement_subject => 14,
        :price_amount => 15,
        :currency => 16,
        :is_VAT_included => 17,
        :source_url => 18,
        :datanest_id => 1

  display_name   'Verejné obstarávania'

  def address
    supplier_region
  end

  def profit
    price_amount
  end

end
