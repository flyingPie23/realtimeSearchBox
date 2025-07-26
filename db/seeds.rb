# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

puts "Cleaning up the database..."
Request.destroy_all

puts "Seeding database with sample data..."

prefix = [ "what is", "where to find", "reviews of"]
queries = []

fake_ips = ["192.168.1.1", "10.0.0.1", "172.16.0.1", "192.168.1.10", "10.0.0.5", "172.16.254.1","203.0.113.7","198.51.100.23","8.8.8.8","127.0.0.1","192.0.2.44","169.254.10.20","10.10.10.10"]

prefix.each do |p|
  5.times do
    query = "#{p} #{Faker::Movie.title}"
    queries << query
  end

  5.times do
    query = "#{p} #{Faker::Book.title}"
    queries << query
  end

  5.times do
    query = "#{p} #{Faker::Music.band}"
    queries << query
  end
end

queries.each do |query|
  puts "Creating request with query: #{query}"

  fake_ips.each do |ip|
    (1..6).to_a.sample.times do
      query = queries.sample
      request = Request.create!(
        query: query,
        ip_adress: ip,
        timestamp: Faker::Time.between(from: 1.month.ago, to: Time.now)
      )

    tracked_request = Request.find_by(ip_adress: ip, query: query)

    if tracked_request && tracked_request.id != request.id
      analytics = RequestAnalytic.find_or_initialize_by(request_id: tracked_request.id)
    else
      analytics = RequestAnalytic.find_or_initialize_by(request_id: request.id)
    end

    analytics.count ||= 0
    analytics.count += 1
    analytics.save!
    end
  end
end
