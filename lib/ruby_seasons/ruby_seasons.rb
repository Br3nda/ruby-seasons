# frozen_string_literal: true

require 'csv'
module RubySeasons
  module ClassMethods
    @@lookup_file = File.expand_path('../lookup_tables/london_seasons.csv', __dir__)

    def season_lookup_table
      @@season_lookup_table ||= get_season_lookup_table
    end

    def get_season(date, hemisphere)
      datetime = date.class == DateTime ? date : DateTime.parse(date.to_s)
      year = datetime.strftime('%Y')
      if (season_lookup_table[year][:spring_start]..season_lookup_table[year][:summer_start]).cover?(datetime)
        'spring'
      elsif (season_lookup_table[year][:summer_start]..season_lookup_table[year][:autumn_start]).cover?(datetime)
        'summer'
      elsif (season_lookup_table[year][:autumn_start]..season_lookup_table[year][:winter_start]).cover?(datetime)
        'autumn'
      else
        'winter'
      end
    end

    private

    def get_season_lookup_table
      @@season_lookup_table = {}

      CSV.foreach(@@lookup_file) do |row|
        @@season_lookup_table[row[0]] = {
          spring_start: DateTime.parse(row[0] + ' ' + row[1]),
          summer_start: DateTime.parse(row[0] + ' ' + row[2]),
          autumn_start: DateTime.parse(row[0] + ' ' + row[3]),
          winter_start: DateTime.parse(row[0] + ' ' + row[4])
        }
      end
      @@season_lookup_table
    end
    extend ClassMethods
  end

  module InstanceMethods
    def season(hemisphere)
      ClassMethods.get_season(self, hemisphere)
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
