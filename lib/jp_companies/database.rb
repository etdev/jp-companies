module JpCompanies
  module Database
    config_file = File.join(File.dirname(__FILE__), "database", "config.yml")
    CONFIG = YAML.load(ERB.new(File.read(config_file)).result)

    # Database accessor singleton
    DB = Sequel.connect(
      adapter: "mysql2",
      user: CONFIG["db_user"],
      host: CONFIG["db_host"],
      password: CONFIG["db_password"],
      database: CONFIG["db_name"]
    )

    def drop_tables
      ensure_okay("This will drop any existing tables.") do
        TABLES.each do |table|
          DB.drop_table?(table)
        end
      end
    end

    def create_tables
      TABLES.each do |table|
        DB.run(sql_schema_file_for(table))
      end
    end

    private

    TABLES = [
      :companies,
      :en_hyouban_entries,
      :vorkers_entries,
      :offices
    ]

    def ensure_okay(message)
      puts "#{message} Is this okay? (y/n)"
      ok = gets.chomp

      if ok.downcase != "y"
        puts "Exiting."; abort
      end

      yield
    end

    def sql_schema_file_for(table)
      File.read(File.join(LIB_ROOT, "jp_companies", "database", "#{table}.sql"))
    end
  end
end
