require 'net/http'
require 'uri'
require 'json'

class Openai
    include ActiveModel::Model

    def self.chat_gpt(api_key, results)
        # APIのエンドポイントを指定
        uri = URI.parse('https://api.openai.com/v1/chat/completions')  # エンドポイントを変更

        # POSTリクエストを作成
        request = Net::HTTP::Post.new(uri)
        request.content_type = 'application/json'
        request['Authorization'] = "Bearer #{api_key}"
        request.body = JSON.dump({
        'model' => 'gpt-3.5-turbo',
        'messages' => [
            {"role": "user", "content": "これから５つの性格診断の問題と回答、回答傾向を入力します。５つすべて記入されてから返答を返してください"},
            {"role": "user", "content": "#{results[0]}"},
            {"role": "user", "content": "#{results[1]}"},
            {"role": "user", "content": "#{results[2]}"},
            {"role": "user", "content": "#{results[3]}"},
            {"role": "user", "content": "#{results[4]}"},
            {"role": "assistant", "content": "これらの結果を踏まえた性格診断を行ない、総評を教えてください"}
        ]
        })

        # リクエストを送信し、レスポンスを受け取る
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
        end

        # レスポンスのJSONデータをパースして返す
        JSON.parse(response.body)
    end
end
