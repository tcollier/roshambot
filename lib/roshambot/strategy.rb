module Roshambot
  class Strategy
    attr_reader :history

    def initialize
      @scores = {}
    end

    def predict(history)
      @history = history
      if best_scoring_strategy
        guesses[best_scoring_strategy.first]
      end
    end

    def update_scores(round)
      winning_throw = self.class.beat round.theirs
      guesses.each_pair do |strategy, guess|
        if guess == winning_throw 
          @scores[strategy] ||= 0
          @scores[strategy] += 1
        end
      end
    end

    # Look for the best match of the last few rounds with the past, assuming there
    # is a pattern to the opponent throws.
    def naive_for_me_0
      self.class.beat their_throw_after_most_recent_max_match
    end

    def naive_for_me_1
      self.class.beat self.class.beat(naive_for_me_0)
    end

    def naive_for_me_2
      self.class.beat self.class.beat(naive_for_me_1)
    end

    def naive_for_them_0
      self.class.beat self.class.beat(my_throw_after_most_recent_max_match)
    end

    def naive_for_them_1
      self.class.beat self.class.beat(naive_for_them_0)
    end

    def naive_for_them_2
      self.class.beat self.class.beat(naive_for_them_1)
    end

    def self.beat(throw)
      case throw
      when :rock
        :paper
      when :scissors
        :rock
      when :paper
        :scissors
      end
    end

  private
    def guesses
      guesses = {}
      all_strategies do |strategy|
        guesses[strategy] = self.send(strategy)
      end
      guesses
    end

    def best_scoring_strategy
      @scores.max_by{ |k,v| v }
    end

    def score_strategies
      all_strategies do |strategy|
        guesses[strategy] = self.send(strategy)
      end
    end

    def all_strategies(&block)
      [:me, :them].each do |who|
        3.times do |depth|
          yield "naive_for_#{who}_#{depth}".to_sym
        end
      end
    end

    def their_throw_after_most_recent_max_match
      return nil if history.match_lengths.max.nil?
      if (max_match = history.match_lengths.max) > 0
        match_index = history.match_lengths.rindex max_match
        history[match_index + 1].theirs
      end
    end

    def my_throw_after_most_recent_max_match
      return nil if history.match_lengths.max.nil?
      if (max_match = history.match_lengths.max) > 0
        match_index = history.match_lengths.rindex max_match
        history[match_index + 1].mine
      end
    end
  end
end