# lib/sinchoku_manager.rb

require 'date'
require_relative 'discord_notifier'

class SinchokuManager
  # 実行すべきかどうかを判断するロジック
  def self.should_run?(time)
    # 0=日, 1=月, 2=火, 3=水, 4=木, 5=金, 6=土
    (1..5).include?(time.wday) # 月曜日から金曜日ならtrue
  end

  # 実際に通知を送るロジック
  def self.perform_check(target)
    puts "Running job for #{target['name']}..."
    DiscordNotifier.send(target['webhook_url'], target['message'])
  end
end