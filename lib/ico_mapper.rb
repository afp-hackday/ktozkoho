module ICOMapper

  Hit = Struct.new(:cardinality, :query, :ico) do
    def to_s
      "#{cardinality}: #{query}"
    end
  end

  EMPTY_QUERY = ''

  def debug msg
    #puts msg
  end

  def ico_map_condition condition
    @ico_map_condition = condition
  end

  def map_icos
    all = 0
    failed = 0
    failed_subjects = []
    success = 0

    @ico_map_condition ||= {:ico => nil}
    all(:conditions => @ico_map_condition).each do |record|

      debug "Mapping #{record.company}"

      organisation = Datanest::Organisation.find_by_name(record.company)
      unless organisation.nil?
        best_hit = Hit.new(1, '', organisation.ico)
      else
        best_hit = fulltext_search(EMPTY_QUERY, record.company)

        debug "Best hit from name search: #{best_hit}"

        if best_hit.cardinality > 1
          best_hit = fulltext_search(best_hit.query, record.address)
        end
      end

      all += 1
      if best_hit.cardinality == 1
        record.ico = best_hit.ico
        record.save!
        success += 1
        print '.'
      else
        failed += 1
        failed_subjects << record
        print 'F'
      end
    end

    "Processed #{all} subjects, succesfully resolved #{success} ICOs, failed: #{failed}"
  end

  def fulltext_search start_with, q
    fulltext_query = start_with
    best_hit = Hit.new(999, '', '')

    q.split(' ').map(&:strip).each do |search_term|
      fulltext_query += " +#{search_term}"
      debug "trying #{fulltext_query}.. "
      icos = Datanest::Organisation.find_by_sql("SELECT ico FROM datanest_organisations WHERE MATCH(name,address) AGAINST('#{fulltext_query}' IN BOOLEAN MODE )")
      debug "#{icos.size}"

      if icos.size == 0
        to = " +#{search_term}".length + 1
        fulltext_query = fulltext_query[0..-to]
        debug "backtracked to #{fulltext_query}"
      else
        best_hit = Hit.new(icos.size, fulltext_query, icos[0].ico) if icos.size < best_hit.cardinality
      end

      break if icos.size == 1
    end unless q.nil?

    best_hit
  end
end
