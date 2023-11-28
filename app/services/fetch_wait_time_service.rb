require 'net/http'
require 'uri'
require 'json'

class FetchWaitTimeService
  def initialize(park:)
    @scraping_services = []
    @park = park
  end

  def execute
    # スクレイピングの情報をとってくる(キャッシュ)
    @scraping_services = cached_scraping_services

    # スクレイピングの情報を使ってアトラクション情報整形
    # note: {id,name,area,thubnail_url,wait_time}
    return attractions_info
  end


  private

    def cached_scraping_services

      # スクレイピングを走らせるため、提供元のサイトへの負荷を軽減させるため
      Rails.cache.fetch("wait_time_#{@park}", expires_in: 15.minutes) do
        uri = URI("https://r5yd59ix1d.execute-api.ap-northeast-1.amazonaws.com/v1/waittime\?park\=#{@park}")
        response = Net::HTTP.get(uri)

        result = JSON.parse(response)
        # resultの例
        # [{ "name": "インディージョーンズ", "condition": "案内終了" },{ "name": "レイジングスピリッツ", "condition": "60" }]
    
        # 失敗時だと{"message"=>"Missing Authentication Token"}と配列サイズが1で返ってくるため
        result.length > 1 ? result : []
      end
    end

    # TODO: 名前変える
    def attractions_info
      attractions = Attraction.all

      # 案内終了となっているアトラクションは除外する
      working_services = @scraping_services.filter do |service|
        service["condition"].match?(/^\d+/)
      end

      # working_services = @scraping_services

      sort_id = 1

      working_attractions = attractions.each_with_object([]) do |attraction,result_array|
        # 公式の掲載にないアトラクションは除外する(グリーティング施設など)
        working_attraction = working_services.find {|service| service["name"] == attraction.scraping_name}

        if working_attraction
          result_array << {
            id: attraction.id,
            name: attraction.name,
            condition: working_attraction["condition"],
            sort_id: sort_id # filter後にランダムでアトラクションを指定する際に必要になるため
          }
          sort_id += 1
        end
      end
      return working_attractions
    end

    def attraction_info
      @attraction_info ||= Attraction.all
    end
end