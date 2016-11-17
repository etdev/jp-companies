module JpCompanies
  module Database
    config_file = File.join(File.dirname(__FILE__), "database", "config.yml")
    config = YAML.load(ERB.new(File.read(config_file)).result)

    # Database accessor singleton
    DB = Sequel.connect(
      adapter: "mysql2",
      user: config["db_user"],
      host: config["db_host"],
      password: config["db_password"],
      database: config["db_name"]
    )
  end
end
