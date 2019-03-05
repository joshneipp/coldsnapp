require 'rails_helper'

describe RandomTimeService do
  describe '.random_minute_in_the_morning' do
    
    subject { RandomTimeService.random_minute_in_the_morning }

    it 'is a time object' do
      expect(subject.class).to eq(Time)
    end
  
    it 'is not the same for two random times' do
      time1 = RandomTimeService.random_minute_in_the_morning
      time2 = RandomTimeService.random_minute_in_the_morning
      expect(time1).not_to eq(time2)
    end
  end
end