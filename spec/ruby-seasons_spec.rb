# frozen_string_literal: true

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'RubySeasons' do
  context 'Date objects' do
    let(:my_birthday) { Date.parse('28th May 1980') }
    it "should return 'spring' for my birthday" do
      expect(my_birthday.season(:north)).to eq 'spring'
    end
    it "should parse my brother's birthday and return 'winter'" do
      expect(Date.get_season('28th December 1977', :north)).to eq 'winter'
    end
  end

  context 'DateTime objects' do
    it "should return 'summer' for my mum's birthday" do
      expect(DateTime.parse('12th September 1946 12:27PM').season(:north)).to eq 'summer'
    end
    it "should parse my dad's birthday and return 'autumn'" do
      expect(DateTime.get_season('5th November 1944 13:42PM', :north)).to eq 'autumn'
    end
  end
end
