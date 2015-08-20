# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

LOCATIONS = [
  {
    name: 'The Manchester Digital Labratory (MadLab)',
    website: 'http://madlab.org.uk',
    street_address: '36-40 Edge Street',
    city: 'Manchester',
    postal_code: 'M4 1HN',
  },
  {
    name: '57 Thomas Street',
    website: 'http://www.marblebeers.com/57thomas-street/',
    street_address: '57 Thomas Street',
    city: 'Manchester',
    postal_code: 'M4 1NA',
  },
  {
    name: 'Federation House',
    street_address: 'Federation Street',
    city: 'Manchester',
    postal_code: 'M4 2AH',
  },
  {
    name: 'Common',
    website: 'http://www.aplacecalledcommon.co.uk/',
    street_address: '39 Edge Street',
    city: 'Manchester',
    postal_code: 'M4 1HW',
  },
  {
    name: 'Kosmonaut',
    website: 'http://kosmonaut.co/',
    street_address: '10 Tariff Street',
    city: 'Manchester',
    postal_code: 'M1 2FF',
  },
  {
    name: 'Manchester Digital Development Agency (MDDA)',
    website: 'http://www.manchesterdda.com/',
    street_address: '117-119 Portland Street',
    city: 'Manchester',
    postal_code: ' M1 6PR',
  },
  {
    name: 'NoHo',
    website: 'http://www.noho-bar.com/',
    street_address: 'Stevenson Square',
    city: 'Manchester',
    postal_code: 'M1 1FB',
  },
  {
    name: 'The Paramount',
    website: 'http://www.jdwetherspoon.co.uk/home/pubs/the-paramount',
    street_address: '33-35 Oxford Street',
    city: 'Manchester',
    postal_code: 'M1 4BH',
  },
  {
    name: 'Port St. Beer House',
    website: 'http://www.portstreetbeerhouse.co.uk/',
    street_address: '39-41 Port Street',
    city: 'Manchester',
    postal_code: 'M1 2EQ',
  },
  {
    name: 'The BBC',
    website: '',
    street_address: 'New Broadcasting House, Oxford Rd',
    city: 'Manchester',
    postal_code: 'M1 5QA',
  },
]

LOCATIONS.each do |attributes|
  Location.create!(attributes) unless Location.exists?(name: attributes[:name])
end

CSV.foreach(Rails.root.join('db/events.csv'), headers: true) do |row|
  Event.create!(
    title: row['title'],
    slug: row['slug'],
    description: row['description'],
    location_id: row['location_id'],
    date: row['date'],
  ) unless Event.exists?(slug: row['slug'])
end
