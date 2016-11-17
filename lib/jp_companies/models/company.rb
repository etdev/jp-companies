module JpCompanies
  module Models
    class Company
      attr_accessor :name, :salary, :rating, :rating_count, :daily_hours_worked

      def initialize(attrs)
        @name = attrs[:name]
        @salary = attrs[:salary]
        @rating = attrs[:rating]
        @rating_count = attrs[:rating_count]
        @daily_hours_worked = attrs[:daily_hours_worked]
      end

      def attributes
        {
          name: @name,
          salary: @salary,
          rating: @rating,
          rating_count: @rating_count,
          daily_hours_worked: @daily_hours_worked,
          created_at: Time.now,
          updated_at: Time.now
        }
      end

      def save(db)
        db[:companies].insert(attributes)
      rescue => e
        "Failed to store company to DB: #{e.message}"
      end

      def self.generate_from_company_item(item)
        attrs = %i(name salary rating rating_count daily_hours_worked).reduce({}) do |attr_hash, el|
          attr_hash.merge({ el => get_via_css(item, el) })
        end
        new(attrs)
      end

      def self.get_via_css(item, element)
        case element
        when :name
          item.css(".companyName > a").text
        when :salary
          item.css(".salary > .num").text[/\d+/].to_i
        when :rating
          item.css("span.point").text[/\d+/].to_i
        when :rating_count
          item.css(".num").text[/\d+/].to_i
        when :daily_hours_worked
          item.css(".time > .num").text[/\d+-\d+/]
        end
      end
    end
  end
end
