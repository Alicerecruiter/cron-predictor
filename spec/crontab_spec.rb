require 'rspec'
require_relative '../lib/crontab'
require 'time'

RSpec.describe Crontab do
  let(:subject) { described_class.new(config) }

  describe "#new" do
    context "with an invalid minute value in the config" do
      let(:config) { "60 * ./example_script.rb" }

      it "should raise an ArgumentError" do
        expect { described_class.new(config) }.to raise_error(ArgumentError)
      end
    end

    context "with an invalid hour value in the config" do
      let(:config) { "* 24 ./example_script.rb" }

      it "should raise an ArgumentError" do
        expect { described_class.new(config) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#next_occurance" do
    context "with an 'every minute' crontab" do
      let(:config) { "* * ./example_script.rb" }
      let(:current_time) { Time.now }

      it "returns the given time" do
        expect(subject.next_occurance(current_time)).to eq current_time
      end
    end

    context "with an 'every 5th minute' crontab" do
      let(:config) { "5 * ./example_script.rb" }

      context "when current time is 10:05" do
        let(:current_time) { Time.parse("10:05", Time.now) }
        
        it "returns the current_time" do
          expect(subject.next_occurance(current_time)).to eq current_time
        end
      end

      context "when the current time is 10:06" do
        let(:current_time) { Time.parse("10:06", Time.now) }
        let(:five_past_eleven) { Time.parse("11:05", current_time) }

        it "returns 11:05" do
          expect(subject.next_occurance(current_time)).to eq five_past_eleven
        end
      end
    end

    context "with an 'every minute of the 10th hour' crontab" do
      let(:config) { "* 10 ./example_script.rb" }

      context "when the current time is 10:00" do
        let(:current_time) { Time.parse("10:00", Time.now) }

        it "returns the current_time" do
          expect(subject.next_occurance(current_time)).to eq current_time
        end
      end

      context "when the current time is 9:59" do
        let(:current_time) { Time.parse("9:59", Time.now) }
        let(:ten_oclock) { Time.parse("10:00", current_time) }

        it "returns 10:00" do
          expect(subject.next_occurance(current_time)).to eq ten_oclock
        end
      end

      context "when the current time is 11:00" do
        let(:current_time) { Time.parse("11:00", Time.now) }
        let(:tomorrow) { current_time + 60*60*24 }
        let(:ten_oclock_tomorrow) { Time.parse("10:00", tomorrow) }

        it "returns 10:00 tomorrow" do
          expect(subject.next_occurance(current_time)).to eq ten_oclock_tomorrow
        end
      end
    end

    context "with an '5th minute of the 10th hour' crontab" do
      let(:config) { "5 10 ./example_script.rb" }

      context "when the current time is 10:05" do
        let(:current_time) { Time.parse("10:05", Time.now) }

        it "returns the current_time" do
          expect(subject.next_occurance(current_time)).to eq current_time
        end
      end

      context "when the current time is 10:04" do
        let(:current_time) { Time.parse("10:04", Time.now) }
        let(:five_past_ten) { Time.parse("10:05", current_time) }

        it "returns the current_time" do
          expect(subject.next_occurance(current_time)).to eq five_past_ten
        end
      end

      context "when the current time is 10:06" do
        let(:current_time) { Time.parse("10:06", Time.now) }
        let(:tomorrow) { current_time + 60*60*24 }
        let(:five_past_ten_tomorrow) { Time.parse("10:05", tomorrow) }

        it "returns the current_time" do
          expect(subject.next_occurance(current_time)).to eq five_past_ten_tomorrow
        end
      end
    end
  end
end
