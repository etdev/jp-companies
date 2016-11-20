module JpCompanies
  module Models
    class VorkersEntry
      TABLE_NAME = :vorkers_entries
      BASE_URL = "http://www.vorkers.com"

      def initialize(attrs)
        @vorkers_id = attrs[:vorkers_id]
        @name = attrs[:name]
        @url = attrs[:url]
        @rating = attrs[:rating]
        @ratings_count = attrs[:ratings_count]
        @monthly_overtime = attrs[:monthly_overtime]
        @percent_vacation_used = attrs[:percent_vacation_used]
        @category = attrs[:category]
        @thumbnail_url = attrs[:thumbnail_url]
        @stock_info = attrs[:stock_info]
      end

      def save(db)
        db[TABLE_NAME].insert(attributes)
      rescue => e
        puts "Failed to store en_hyouban entry to DB: #{e.message}"
      end

      def self.generate_from_company_item(item)
        attrs = %i(
          vorkers_id name url rating ratings_count monthly_overtime
          percent_vacation_used category thumbnail_url stock_info
        )
        attrs = attrs.reduce({}) do |attr_hash, el|
          attr_hash.merge({ el => get_via_css(item, el) })
        end
        new(attrs)
      end

      private

      def attributes
        {
          vorkers_id: @vorkers_id,
          name: @name,
          url: @url,
          rating: @rating,
          ratings_count: @ratings_count,
          monthly_overtime: @monthly_overtime,
          percent_vacation_used: @percent_vacation_used,
          category: @category,
          thumbnail_url: @thumbnail_url,
          stock_info: @stock_info,
          created_at: Time.now,
          updated_at: Time.now
        }
      end

      def self.get_via_css(item, element)
        case element
        when :vorkers_id
          item.css(".searchCompanyName .fs-16 > a").attr("href").value[/m_id=(.*)/, 1]
        when :name
          item.css(".searchCompanyName .fs-16 > a").text.strip
        when :url
          "#{BASE_URL}#{item.css(".searchCompanyName .fs-16 > a").attr("href").value}"
        when :rating
          item.css(".totalEvaluation_item.fw-b").text.strip.to_f
        when :ratings_count
          item.css(".mt-5.lh-1o3 .d-ib .d-ib")[0].text[/\A(\d+)件/, 1].strip.to_i
        when :monthly_overtime
          item.css(".mt-5.lh-1o3 .d-ib .d-ib")[1].text[/\A(.*)時間/, 1].strip.to_f
        when :percent_vacation_used
          item.css(".mt-5.lh-1o3 .d-ib .d-ib")[2].text[/\A(.*)%/, 1].strip.to_f
        when :category
          item.css(".mt-5.middlegray > li")[0].text
        when :thumbnail_url
          item.css(".searchCompanyLogoArea .companyLogoImage").attr("src").value
        when :stock_info
          stock_info_element = item.css(".mt-5.middlegray > li")[1]
          if stock_info_element
            stock_info_element.text.strip[/\A\[(.*)\]/, 1]
          else
            ""
          end
        end
      rescue => e
        puts "Failed to parse DOM element: #{e.message}"
        puts e.backtrace.join("\n")
      end
    end
  end
end
