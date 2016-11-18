module JpCompanies
  module Crawlers
    class EnHyouban
      include JpCompanies::Database

      MAX_PAGE_COUNT = 600
      BASE_URL = "https://en-hyouban.com/search/internet_it"
      SLEEP_INTERVAL = 0.5

      def crawl
        all_pages do |page|
          crawl_page(page)
        end
      end

      private

      def url_for_page(page_num)
        "#{BASE_URL}/#{page_num}"
      end

      def crawl_page(page)
        page.css(".searchListUnit").each do |company_item|
          begin
            company = JpCompanies::Models::EnHyoubanEntry.generate_from_company_item(company_item)
            company.save(DB)
          rescue => e
            puts "Failed to crawl company_item: #{e.message}"; next
          end
        end
      end

      def all_pages
        (1..MAX_PAGE_COUNT).each do |page_num|
          begin
            puts "Crawling page ##{page_num} of #{MAX_PAGE_COUNT}"
            page = Nokogiri::HTML(open(url_for_page(page_num)))
            yield(page)
          rescue => e
            puts "Failed to crawl page: #{e.message}"; next
          end
          sleep(SLEEP_INTERVAL)
        end
      end

    end
  end
end
