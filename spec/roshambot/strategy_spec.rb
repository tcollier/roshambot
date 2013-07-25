require 'roshambot/strategy'
require 'roshambot/matching_history'
require 'roshambo/competitor/history'

describe Roshambot::Strategy do
  it "broken" do
    subject = Roshambot::Strategy.new
    history = Roshambot::MatchingHistory.new
    history.add(Roshambo::Competitor::History::Round.new(:rock, :rock))
    history.add(Roshambo::Competitor::History::Round.new(:rock, :rock))
    thrown = subject.predict(history)
    puts subject.guesses
    thrown.should == :paper
  end
  
  context "basic strategy" do
    let(:history) { double('history', :match_lengths => [0, 2, 1]) }
    let(:subject) { Roshambot::Strategy.new }

    before(:each) do
      history.stub(:[]).with(2).and_return(Roshambo::Competitor::History::Round.new(:rock, :rock))
      subject.stub(:history => history)
    end

    describe "#naive_for_me_0" do
      it { subject.naive_for_me_0.should == :paper }
    end

    describe "#naive_for_me_1" do
      it { subject.naive_for_me_1.should == :rock }
    end

    describe "#naive_for_me_2" do
      it { subject.naive_for_me_2.should == :scissors }
    end

    describe "#naive_for_them_0" do
      it { subject.naive_for_them_0.should == :scissors }
    end

    describe "#naive_for_them_1" do
      it { subject.naive_for_them_1.should == :paper }
    end

    describe "#naive_for_them_2" do
      it { subject.naive_for_them_2.should == :rock }
    end
  end
end