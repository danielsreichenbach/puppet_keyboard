require 'spec_helper'
describe 'keyboard' do

  context 'with defaults for all parameters' do
    it { should contain_class('keyboard') }
  end
end
