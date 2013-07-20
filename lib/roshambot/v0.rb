require 'roshambo'

module Roshambot
  class V0 < Roshambo::Competitor::Player
    def initialize
      @history = MatchingHistory.new
    end

    def throw
      Me.obvious(history) || VALID_THROWS[(seed * history * 7) % 3]
    end

  private
    def best_match_for_me
      if history.length > 0
        best_match(:me)
      end
    end

    def best_match_for_opponent
      if history.length > 0
        best_match
      end
    end
  end
end