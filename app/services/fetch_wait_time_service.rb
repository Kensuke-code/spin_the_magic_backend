require 'net/http'
require 'uri'
require 'json'

class FetchWaitTimeService
  def initialize
    @wait_time_info = []
  end

  def execute
    cached_wait_times
  end


  private

    def cached_wait_times
      Rails.cache.fetch("wait_time", expires_in: 1.day) do
        park = 'sea'
        uri = URI("https://r5yd59ix1d.execute-api.ap-northeast-1.amazonaws.com/v1/waittime\?park\=#{park}")
        response = Net::HTTP.get(uri)
        result = JSON.parse(response)
    
        # 失敗時だと{"message"=>"Missing Authentication Token"}と配列サイズが1で返ってくるため
        result.length > 1 ? result : []
      end
    end
end