#encoding: utf-8
class Company < Subject
  PROBLEMATIC_PARTS = ['s.r.o.', 'a.s.', 'Bratislava'].freeze

  def self.clean_name name
    PROBLEMATIC_PARTS.each { |p| name.gsub!(p, '') }
    name.gsub!('PD', 'Poľnohospodárske družstvo')
    name.gsub!('RD', 'Roľnícke družstvo')
    name
  end
end
