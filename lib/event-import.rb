require 'csv'
require 'reverse_markdown'

CSV.foreach('tmp/events_dump.csv', headers: true) do |row|
  Event.create!(
    title: row[1],
    slug: row[2],
    description: ReverseMarkdown.convert(row[3]),
    date: row[4],
  )
end
