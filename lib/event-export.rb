require 'csv'

CSV.open(Rails.root.join('db/events.csv'), 'w') do |csv|
  csv << %w(title slug description location_id date)

  Event.all.each do |event|
    csv << [
      event.title.force_encoding(Encoding::UTF_8),
      event.slug,
      event.description.force_encoding(Encoding::UTF_8),
      event.location_id,
      event.date
    ]
  end
end

# CSV.foreach('tmp/events_dump.csv', headers: true) do |row|
#   Event.create!(
#     title: row[1],
#     slug: row[2],
#     description: ReverseMarkdown.convert(row[3]),
#     date: row[4],
#   )
# end
