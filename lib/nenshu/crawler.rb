require "rubygems"
require "nokogiri"
require "sequel"
require "open-uri"
require "pry"
require_relative "./company_vorkers"
require_relative "./company_en_hyouban"

PAGE_COUNT = 5147.fdiv(10).ceil
BASE_URL = "https://en-hyouban.com/search/internet_it"
DB = Sequel.connect(adapter: "mysql2", user: "root", host: "localhost", database: "nenshu")

def url_for_page(page_num)
  "#{BASE_URL}/#{page_num}"
end

(1..PAGE_COUNT).each do |page_num|
  puts "Crawling page ##{page_num} of #{PAGE_COUNT}"
  begin
    page = Nokogiri::HTML(open(url_for_page(page_num)))
    company_items = page.css(".searchListUnit")
    company_items.each do |company_item|
      begin
        company = Nenshu::Company.generate_from_company_item(company_item)
        company.save(DB)
      rescue => e
        puts "Failed to crawl company_item: #{e.message}"
        next
      end
    end
  rescue => e
    puts "Failed to crawl page: #{e.message}"
    next
  end
  sleep(0.1)
end
