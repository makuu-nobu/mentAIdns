require 'net/http'
require 'uri'
require 'json'

class Openai
    include ActiveModel::Model

    def self.chat_gpt(api_key, question)
        # APIのエンドポイントを指定
        uri = URI.parse('https://api.openai.com/v1/completions')  # エンドポイントを変更

        # POSTリクエストを作成
        request = Net::HTTP::Post.new(uri)
        request.content_type = 'application/json'
        request['Authorization'] = "Bearer #{api_key}"
        request.body = JSON.dump({
        'model' => 'text-davinci-003',
        'prompt' => question,
        'max_tokens' => 150  # 必要に応じて調整
        })

        # リクエストを送信し、レスポンスを受け取る
        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
        end

        # レスポンスのJSONデータをパースして返す
        JSON.parse(response.body)
    end
end
