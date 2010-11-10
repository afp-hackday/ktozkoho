module MappingHelper
  def manual_mapping_category model_class
    percent_mapped = model_class.percent_of_mapped
    return 'nearly_unmapped' if percent_mapped < 0.2 
    return 'badly_mapped' if percent_mapped < 0.5
    return 'well_mapped' if percent_mapped < 0.7
    return 'excellently_mapped' if percent_mapped < 0.9
    return 'all_mapped'
  end
end
