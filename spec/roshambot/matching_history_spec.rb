require 'roshambot/matching_history'
require 'roshambo/competitor/history'

describe Roshambot::MatchingHistory do
  # describe '#longest_match' do
  #   it "returns nil if the history is empty" do
  #     history = Roshambot::MatchingHistory.new
  #     Roshambot::MatchingHistory.new.send(:longest_match, history).should be_nil
  #   end
  # 
  #   it "returns nil if the history is only has 1 throw" do
  #     history = Roshambot::MatchingHistory.new
  #     history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
  #     Roshambot::MatchingHistory.new.send(:longest_match, history).should be_nil
  #   end
  # 
  #   it "returns the index of the last throw of the longest match when there is only 1 match" do
  #     history = Roshambot::MatchingHistory.new
  #     history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
  #     history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
  #     Roshambot::MatchingHistory.new.send(:longest_match, history).should == 0
  #   end
  # 
  #   it "returns the index of the last throw of the most recent longest match when there are multiple longest matches" do
  #     history = Roshambot::MatchingHistory.new
  #     history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
  #     history.add(Roshambo::Competitor::History::Round.new(:scissors, :rock))
  #     history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
  #     history.add(Roshambo::Competitor::History::Round.new(:scissors, :rock))
  #     history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
  #     history.add(Roshambo::Competitor::History::Round.new(:scissors, :rock))
  #     Roshambot::MatchingHistory.new.send(:longest_match, history).should == 1
  #   end
  # end

  describe '#to_matches' do
    it do
      history = Roshambot::MatchingHistory.new
      history.match_lengths.should == []
    end

    it do
      history = Roshambot::MatchingHistory.new
      history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
      history.match_lengths.should == []
    end

    it do
      history = Roshambot::MatchingHistory.new
      history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
      history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
      history.match_lengths.should == [1]
    end

    it do
      history = Roshambot::MatchingHistory.new
      history.add(Roshambo::Competitor::History::Round.new(:rock, :scissors))
      history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
      history.match_lengths.should == [0]
    end

    it do
      history = Roshambot::MatchingHistory.new
      history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
      history.add(Roshambo::Competitor::History::Round.new(:scissors, :rock))
      history.add(Roshambo::Competitor::History::Round.new(:scissors, :rock))
      history.add(Roshambo::Competitor::History::Round.new(:rock, :paper))
      history.add(Roshambo::Competitor::History::Round.new(:scissors, :rock))
      history.match_lengths.should == [0, 2, 1, 0]
    end
  end
end