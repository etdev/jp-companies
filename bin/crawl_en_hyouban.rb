$LOAD_PATH.unshift(File.expand_path("../../lib", __FILE__))

require "jp_companies"

crawler = JpCompanies::Crawlers::EnHyouban.new.crawl
