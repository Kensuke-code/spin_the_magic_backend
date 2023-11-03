require 'net/http'
require 'uri'
require 'json'

class FetchWaitTimeService
  def initialize ; end

  def execute
    cached_wait_times
  end


  private

    def cached_wait_times

      # スクレイピングを走らせるため、提供元のサイトへの負荷を軽減させるため
      Rails.cache.fetch("wait_time", expires_in: 1.day) do
        park = 'sea'
        uri = URI("https://r5yd59ix1d.execute-api.ap-northeast-1.amazonaws.com/v1/waittime\?park\=#{park}")
        response = Net::HTTP.get(uri)

        result = JSON.parse(response)
        # resultの例
        # [{ "name": "インディージョーンズ", "condition": "案内終了" },{ "name": "レイジングスピリッツ", "condition": "案内終了" }]
    
        # 失敗時だと{"message"=>"Missing Authentication Token"}と配列サイズが1で返ってくるため
        result.length > 1 ? result : []
      end
    end
end