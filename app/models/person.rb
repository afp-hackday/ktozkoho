class Person < Subject
  def load_connections
    ::FoafProxy.related_companies(name, address).each do |related|
      related_subject = Subject.find_by_name_fuzzy(related)
      connections.create(:connected_subject => related_subject)
    end
  end
end
