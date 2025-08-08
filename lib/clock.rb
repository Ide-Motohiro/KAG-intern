# lib/clock.rb

require 'clockwork'
require 'yaml'
require_relative 'discord_notifier' 
# DateやTimeオブジェクトを扱うため、dateを読み込んでおくと安全です
require 'date'

module Clockwork
  config = YAML.load_file('./config/settings.yml')

  config['targets'].each do |target|
    # ↓ この行に if: オプションを追加します
    every(1.day, target['name'], at: target['schedule_time'], if: ->(t){ (1..5).include?(t.wday) }) do
      puts "Running job for #{target['name']}..."
      DiscordNotifier.send(target['webhook_url'], target['message'])
    end
  end

  puts "#{config['targets'].size}個のスケジュールを起動しました。"
end