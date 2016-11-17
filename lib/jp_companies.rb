require "rubygems"
require "nokogiri"
require "sequel"
require "open-uri"
require "erb"
require "yaml"

LIB_ROOT = File.dirname(__FILE__)

require "jp_companies/database"
require "jp_companies/crawlers"
require "jp_companies/models"
