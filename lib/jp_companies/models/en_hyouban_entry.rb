module JpCompanies
  module Models
    class EnHyoubanEntry
      TABLE_NAME = :en_hyouban_entries
      BASE_URL = "https://en-hyouban.com"

      def initialize(attrs)
        @en_hyouban_id = attrs[:en_hyouban_id]
        @name = attrs[:name]
        @average_salary = attrs[:average_salary]
        @location = attrs[:location]
        @url = attrs[:url]
        @rating = attrs[:rating]
        @ratings_count = attrs[:ratings_count]
        @daily_hours_worked = attrs[:daily_hours_worked]
        @category = attrs[:category]
      end

      def save(db)
        db[TABLE_NAME].insert(attributes)
      rescue => e
        "Failed to store en_hyouban entry to DB: #{e.message}"
      end

      def self.generate_from_company_item(item)
        attrs = %i(
          en_hyouban_id name average_salary location url rating ratings_count
          daily_hours_worked category
        )
        attrs = attrs.reduce({}) do |attr_hash, el|
          attr_hash.merge({ el => get_via_css(item, el) })
        end
        new(attrs)
      end

      private

      def attributes
        {
          en_hyouban_id: @en_hyouban_id,
          name: @name,
          average_salary: @average_salary,
          location: @location,
          url: @url,
          rating: @rating,
          ratings_count: @ratings_count,
          daily_hours_worked: @daily_hours_worked,
          category: @category,
          created_at: Time.now,
          updated_at: Time.now
        }
      end

      def self.get_via_css(item, element)
        case element
        when :en_hyouban_id
          item.css(".companyName > a").attr("href").value.split("/").last.to_i
        when :name
          item.css(".companyName > a").text
        when :average_salary
          item.css(".salary > .num").text[/\d+/].to_i
        when :location
          item.css(".area").text
        when :url
          "#{BASE_URL}#{item.css(".companyName > a").attr("href").value}"
        when :rating
          item.css("span.point").text[/\d+/].to_i
        when :ratings_count
          item.css(".num").text[/\d+/].to_i
        when :daily_hours_worked
          item.css(".time > .num").text[/\d+-\d+/]
        when :category
          item.css(".subDataArea .category span").map(&:text).join("、")
        end
      end
    end
  end
end
