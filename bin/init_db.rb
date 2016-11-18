$LOAD_PATH.unshift(File.expand_path("../../lib", __FILE__))

require "jp_companies"
include JpCompanies::Database

# Drop existing jp_companies tables and re-create from schema files
puts "Initializing database tables"

begin
  drop_tables
  create_tables
rescue => e
  puts "Database init failed: #{e.message}\n#{e.backtrace.join("\n")}"; abort
end

puts "Database tables successfully created"
