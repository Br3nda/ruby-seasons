# frozen_string_literal: true

require 'spec_helper'

class DummyClass
  include RubySeasons
end

describe RubySeasons do
  let(:table) { DummyClass.season_lookup_table }

  it { expect(table).to be_a Hash }
  it { expect(table['1900'][:spring_start]).to eq DateTime.parse('1900 Mar-21 1:39 AM GMT') }
end
