$LOAD_PATH.unshift(File.expand_path("../../lib", __FILE__))

require "jp_companies"

JpCompanies::Crawlers::EnHyouban.new.crawl
