$LOAD_PATH.unshift(File.expand_path("../../lib", __FILE__))

require "jp_companies"
include JpCompanies::Database

clear_schema_sql_file = File.join(LIB_ROOT, "jp_companies", "database", "clear_schema.sql")
schema_sql_file = File.join(LIB_ROOT, "jp_companies", "database", "schema.sql")

schema_clear_sql = File.read(clear_schema_sql_file)
schema_create_sql = File.read(schema_sql_file)

puts "This will destroy and re-create any existing tables.  Is this okay? (y/n)"
ok = gets.chomp

if ok.downcase != "y"
  puts "Exiting."; abort
end

puts "Initializing database tables"

begin
  DB.run(schema_clear_sql)
  DB.run(schema_create_sql)
rescue => e
  puts "Database init failed: #{e.message}\n#{e.backtrace.join("\n")}"; abort
end

puts "Database tables successfully created"
