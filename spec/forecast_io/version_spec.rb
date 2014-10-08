require 'spec_helper'

describe 'ForecastIO::VERSION' do
  it 'should be the correct version' do
    ForecastIO::VERSION.should == '2.0.1'
  end
end
