module JpCompanies
  module Crawlers
    class EnHyouban
      PAGE_COUNT = 300
      BASE_URL = "https://en-hyouban.com/search/internet_it"

      attr_reader :db

      def initialize
        @db = Sequel.connect(
          adapter: "mysql2",
          user: "root",
          host: "localhost",
          database: "jp_companies"
        )
      end

      def crawl
        (1..PAGE_COUNT).each do |page_num|
          puts "Crawling page ##{page_num} of #{PAGE_COUNT}"
          begin
            page = Nokogiri::HTML(open(url_for_page(page_num)))
            crawl_page(page)
          rescue => e
            puts "Failed to crawl page: #{e.message}"
            next
          end
          sleep(0.2)
        end
      end

      private

      def url_for_page(page_num)
        "#{BASE_URL}/#{page_num}"
      end

      def crawl_page(page)
        company_items = page.css(".searchListUnit")
        company_items.each do |company_item|
          begin
            company = JpCompanies::Models::Company.generate_from_company_item(company_item)
            company.save(db)
          rescue => e
            puts "Failed to crawl company_item: #{e.message}"
            next
          end
        end
      end

    end
  end
end
