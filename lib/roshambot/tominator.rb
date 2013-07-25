require 'roshambo'

module Roshambot
  class Tominator < Roshambo::Competitor::Player
    attr_reader :strategy

    def initialize
      @history = MatchingHistory.new
      @strategy = Strategy.new
    end

    def throw
      track_and_throw(predict || pseudo_random_throw)
    end

    def last_competitor_throw=(thrown)
      super
      strategy.update_scores(history.last)
    end

  private
    def predict
      strategy.predict(history)
    end

    def pseudo_random_throw
      Roshambo::Match::VALID_THROWS[((seed || 0.3) * (history.length + 5) * 7) % 3]
    end
  end
end