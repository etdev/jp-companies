require "rubygems"
require "nokogiri"
require "sequel"
require "open-uri"
require "erb"
require "pry"
require "pry-byebug"
require "yaml"
require "rest-client"

LIB_ROOT = File.dirname(__FILE__)

config_file = File.join(File.dirname(__FILE__), "jp_companies", "config.yml")
CONFIG = YAML.load(ERB.new(File.read(config_file)).result)

require "jp_companies/database"
require "jp_companies/crawlers"
require "jp_companies/models"
