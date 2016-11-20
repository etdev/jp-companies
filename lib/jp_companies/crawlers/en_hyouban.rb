module JpCompanies
  module Crawlers
    class EnHyouban
      include JpCompanies::Database

      COMPANIES_PER_PAGE = 10
      LIST_PAGE_URLS = [
        "https://en-hyouban.com/search/service/",
        "https://en-hyouban.com/search/others/",
        "https://en-hyouban.com/search/koukoku/",
        "https://en-hyouban.com/search/kyouiku_iryo/",
        "https://en-hyouban.com/search/internet_it"
      ]
      SLEEP_INTERVAL = 0.2

      def crawl
        all_list_page_urls do |list_page_url|
          all_pages(list_page_url) do |page|
            crawl_page(page)
          end
        end
      end

      private

      def get_max_page_count(list_page_url)
        page = Nokogiri::HTML(open(url_for_page(list_page_url, 1)))
        page.css(".md_pagenation em")[0].text.to_i.fdiv(COMPANIES_PER_PAGE).ceil
      end

      def url_for_page(list_page_url, page_num)
        "#{list_page_url}/#{page_num}"
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

      # do for all paginated pages in particular category
      def all_pages(list_page_url)
        max_page_count = get_max_page_count(list_page_url)
        puts "max_page_count: #{max_page_count}"
        (1..max_page_count).each do |page_num|
          begin
            puts "Crawling page ##{page_num} of #{max_page_count}"
            page = Nokogiri::HTML(open(url_for_page(list_page_url, page_num)))
            yield(page)
          rescue => e
            puts "Failed to crawl page: #{e.message}"; next
          end
          sleep(SLEEP_INTERVAL)
        end
      end

      # do for company list pages for each category
      def all_list_page_urls
        LIST_PAGE_URLS.each_with_index do |list_page_url, i|
          begin
            puts "-- Crawling #{list_page_url} (#{i + 1} of #{LIST_PAGE_URLS.count}) --"
            yield(list_page_url)
          rescue => e
            puts "Failed to crawl list_page_url:#{e.message}"; next
          end
        end
      end

    end
  end
end
