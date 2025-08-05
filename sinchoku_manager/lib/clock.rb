# lib/clock.rb

require 'clockwork'
require 'yaml'
# 先ほど作った通知用プログラムを読み込む
require_relative 'discord_notifier' 

module Clockwork
  # 設定ファイルから時刻とメッセージを読み込む
  config = YAML.load_file('./config/settings.yml')
  schedule_time = config.dig('schedule', 'time')
  message = config.dig('schedule', 'message')

  # 実行する処理（ジョブ）を定義
  handler do |job_name|
    puts "ジョブ '#{job_name}' を実行します..."
    DiscordNotifier.send(message)
  end

  # 毎日、設定ファイルで指定した時刻にジョブを実行
  every(1.day, 'daily.progress_check', at: schedule_time)

  puts "スケジューラを起動しました。毎日#{schedule_time}に通知を送ります。"
end
