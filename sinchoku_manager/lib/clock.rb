# lib/clock.rb

require 'clockwork'
require 'yaml'
require_relative 'discord_notifier' 

module Clockwork
  config = YAML.load_file('./config/settings.yml')

  # targetsリストの各要素に対して、それぞれスケジュールを設定
  config['targets'].each do |target|
    every(1.day, target['name'], at: target['schedule_time']) do
      puts "Running job for #{target['name']}..."
      DiscordNotifier.send(target['webhook_url'], target['message'])
    end
  end

  puts "#{config['targets'].size}個のスケジュールを起動しました。"
end
