require 'spec_helper'

describe Basecamp::ImportLogger do

  describe '.initialize' do
    it 'raises an error when the log level is invalid' do
      lambda { Basecamp::ImportLogger.new(:invalid_level) }.should raise_error
    end
  end

  describe '#log' do

    context 'in debug mode' do

      before :each do
        @logger = Basecamp::ImportLogger.new(:debug)
      end

      it 'logs info messages' do
        capture(:stdout) { @logger.log('a message', :info) }.should == ("a message\n")
      end

      it 'logs debug messages' do
        capture(:stdout) { @logger.log('a message', :debug) }.should == ("a message\n")
      end

    end

    context 'in info mode' do

      before :each do
        @logger = Basecamp::ImportLogger.new(:info)
      end

      it 'logs info messages' do
        capture(:stdout) { @logger.log('a message', :info) }.should == ("a message\n")
      end

      it 'does not log debug messages' do
        capture(:stdout) { @logger.log('a message', :debug) }.should be_blank
      end

    end
  end
end
