module JpCompanies
  module Crawlers
    class Vorkers
      include JpCompanies::Database

      COMPANIES_PER_PAGE = 25
      LIST_PAGE_URLS = [
        "http://www.vorkers.com/company_list?field=0025&src_str=&sort=1",
        "http://www.vorkers.com/company_list?field=0026&src_str=&sort=1",
        "http://www.vorkers.com/company_list?field=0090&src_str=&sort=1",
        "http://www.vorkers.com/company_list?field=0067&src_str=&sort=1",
        "http://www.vorkers.com/company_list?field=0021&src_str=&sort=1"
      ]

      SLEEP_INTERVAL = 1.5

      def crawl
        all_list_page_urls do |list_page_url|
          all_pages(list_page_url) do |page|
            crawl_page(page)
          end
        end
      end

      def get_with_auth_headers(url)
        RestClient.get(url, get_headers).body
      end

      private

      def get_max_page_count(list_page_url)
        page = get_page(list_page_url, 1)
        page.css(".jsResultCount").text.tr(",", "").to_i.fdiv(COMPANIES_PER_PAGE).ceil
      end

      def get_page(list_page_url, page_num)
        html = get_with_auth_headers(url_for_page(list_page_url, page_num))
        Nokogiri::HTML(html)
      end

      def url_for_page(list_page_url, page_num)
        "#{list_page_url}&next_page=#{page_num}"
      end

      def crawl_page(page)
        page.css(".box-15").each do |company_item|
          begin
            company = JpCompanies::Models::VorkersEntry.generate_from_company_item(company_item)
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
            page = get_page(list_page_url, page_num)
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

      def get_headers
        {
          accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
          accept_encoding: "gzip, deflate, sdch",
          accept_language: "en-US,en;q=0.8,ja;q=0.6",
          cache_control: "max-age=0",
          connection: "keep-alive",
          host: "www.vorkers.com",
          referer: "http://www.vorkers.com/company_list?field=0021&src_str=&sort=1",
          cookie: CONFIG["vorkers_cookie"],
        }
      end

    end
  end
end
