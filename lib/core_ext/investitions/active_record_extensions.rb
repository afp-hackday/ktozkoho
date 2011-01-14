module Investitions::ActiveRecordExtensions
  def with_trigram_similarity sim, &block
    connection.execute "SELECT set_limit(#{sim})"
    result = block.call
    connection.execute "SELECT set_limit(0.3)"
    result
  end
end
