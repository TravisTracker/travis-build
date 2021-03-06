require 'spec_helper'
require 'travis/build'

describe Travis::Build::Job::Test::Haskell do
  let(:shell)  { stub('shell') }
  let(:config) { described_class::Config.new }
  let(:job)    { described_class.new(shell, Hashr.new(:repository => {
                                                        :slug => "owner/repo"
                                                      }), config) }

  describe 'install' do
    it "uses cabal" do
      job.install.should == "cabal install --enable-tests"
    end
  end


  describe 'script' do
    it "uses cabal" do
      job.script.should == "cabal test"
    end
  end
end
