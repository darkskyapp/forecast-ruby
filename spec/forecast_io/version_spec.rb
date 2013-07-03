require 'spec_helper'

describe 'Forecast::IO::VERSION' do
  it 'should be the correct version' do
    Forecast::IO::VERSION.should == '1.2.0'
  end
end