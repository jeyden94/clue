# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

puts "Seeding squares..."

# Clear existing data
Square.destroy_all

# Seed from the CSV file
CSV.foreach(Rails.root.join('db', 'squares_ - Sheet1.csv'), headers: true) do |row|
  Square.create(
    location: row['location'],
    x_coordinate: row['x_coordinate'].to_i,
    y_coordinate: row['y_coordinate'].to_i
  )
end

puts "Squares seeded successfully!"

Room.destroy_all # Ensures the table is clean before adding records
Room.create([{ room_name: 'Kitchen' }, { room_name: 'Ballroom' }, { room_name: 'Conservatory' }, { room_name: 'Dining Room' }, { room_name: 'Billiard Room' }, { room_name: 'Library' }, { room_name: 'Lounge' }, { room_name: 'Hall' }, { room_name: 'Study' }])

Weapon.destroy_all
Weapon.create([{ weapon_name: 'Knife' }, { weapon_name: 'Candlestick' }, { weapon_name: 'Revolver' }, { weapon_name: 'Rope' }, { weapon_name: 'Lead Pipe' }, { weapon_name: 'Wrench' }])

Suspect.destroy_all # Clears existing records to avoid duplication

Suspect.create([
  { suspect_name: 'Miss Scarlet', suspect_color: 'Red' },
  { suspect_name: 'Colonel Mustard', suspect_color: 'Yellow' },
  { suspect_name: 'Mrs. White', suspect_color: 'White' },
  { suspect_name: 'Mr. Green', suspect_color: 'Green' },
  { suspect_name: 'Mrs. Peacock', suspect_color: 'Blue' },
  { suspect_name: 'Professor Plum', suspect_color: 'Purple' }
])
