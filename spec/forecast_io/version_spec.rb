require 'spec_helper'

describe 'ForecastIO::VERSION' do
  it 'should be the correct version' do
    ForecastIO::VERSION.should == '1.2.0'
  end
end
