# lib/discord_notifier.rb

require 'httparty'
require 'json'

class DiscordNotifier
  def self.send(webhook_url, message) # 引数にwebhook_urlを追加
    if webhook_url.nil? || webhook_url.empty?
      puts "[ERROR] Webhook URLが設定されていません。"
      return
    end

    response = HTTParty.post(
      webhook_url, # 引数で受け取ったURLを使う
      body: { content: message }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )
    
    puts response.success? ? "メッセージを正常に送信しました。" : "メッセージの送信に失敗しました: #{response.body}"
  end
end
