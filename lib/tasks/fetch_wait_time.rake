namespace :wait_time do
  desc "Fetch Disney Watit Time"
  task :fetch => :environment do
    
    result_string = %x|curl https://r5yd59ix1d.execute-api.ap-northeast-1.amazonaws.com/v1/waittime\?park\=land|
    result = JSON.parse(result_string)

    # 失敗時だと{"message"=>"Missing Authentication Token"}と配列サイズが1で返ってくるため
    if result.length > 1
      puts "シェルスクリプトが正常に実行されました。"
      puts result.second
    else
      puts "シェルスクリプトの実行中にエラーが発生しました。"
    end

  end
end