# lib/discord_notifier.rb

require 'httparty' # HTTPリクエストを簡単にする
require 'yaml'     # YAMLファイルを読み込む
require 'json'

class DiscordNotifier
  # 設定ファイルを読み込む
  CONFIG = YAML.load_file('./config/settings.yml')
  WEBHOOK_URL = CONFIG.dig('discord', 'webhook_url')

  def self.send(message)
    # Webhook URLが設定されていなければエラーにする
    if WEBHOOK_URL.nil? || WEBHOOK_URL.empty?
      puts "[ERROR] Webhook URLが設定されていません。config/settings.ymlを確認してください。"
      return
    end

    # HTTPartyを使ってDiscordにPOSTリクエストを送信
    response = HTTParty.post(
      WEBHOOK_URL,
      body: { content: message }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
    
    # 送信結果をコンソールに表示
    puts response.success? ? "メッセージを正常に送信しました。" : "メッセージの送信に失敗しました: #{response.body}"
  end
end
