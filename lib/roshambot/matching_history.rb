require 'roshambo/competitor/history'

module Roshambot
  class MatchingHistory < Roshambo::Competitor::History
    def match_lengths
      @_match_arrays ||= []
      @_match_arrays[length] ||= begin
        (length - 1).times.collect do |search_start_index|
          match_count_for(search_start_index)
        end
      end
    end

    def reset
      super
      @_match_arrays = nil
    end

  private
    def match_count_for(search_start_index)
      match_count = 0
      search_start_index.downto(0) do |search_index|
        curr_index = length - 1 - (search_start_index - search_index)
        if self[search_index] == self[curr_index]
          match_count += 1
        else
          break
        end
      end
      match_count
    end
  end
end