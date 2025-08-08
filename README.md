# sinchoku_manager

進捗確認メッセージをDiscordに自動送信するスケジューラーです。  
指定した曜日・時刻に、複数のDiscordチャンネルへリマインダーを送信できます。

## 機能

- `config/settings.yml` で複数ジョブ（送信先・メッセージ・時刻）を設定可能
- 平日（月〜金）のみ送信
- Docker対応
- RSpecによるテスト

## 注意点

- 本プログラムはサーバー等で常時稼働していない場合、指定時刻にメッセージが送信されません。  
  必ずプログラムを実行した状態を維持してください。
- DiscordのWebhook URLは第三者に知られないように管理してください。  
  不正利用される可能性があります。
- メンションを利用する場合は、Discordの「開発者モード」をONにしてIDを取得してください。
- 設定ファイル（`config/settings.yml`）の書式ミスや、Webhook URLの誤りがあるとメッセージ送信に失敗します。
- Docker環境で運用する場合は、設定ファイルや依存関係が正しくコピーされていることを確認してください。
- sinchoku-managerはRubyとNode.jsを必要とするため、必要とされたら都度インストールしてください。

## セットアップ

1. 必要なGemをインストール

```sh
bundle install
```

2. 設定ファイルを編集  
`config/settings.yml` の `targets` に送信したいDiscord Webhook URLやメッセージ、時刻を記載します。

```yml
targets:
  - name: "soft_reminder_job"
    webhook_url: "https://discord.com/api/webhooks/..."
    schedule_time: "16:20"
    message: "<@&ROLE_ID> 進捗どうですか？"
```

**メンションを入れる場合の注意**  
DiscordでユーザーやロールのIDを取得するには、Discordの「開発者モード」をONにしてください。  
1. Discordの「ユーザー設定」→「詳細設定」→「開発者モード」をON  
2. メンションしたいユーザーやロールを右クリックし「IDをコピー」  
3. メッセージ内で `<@ID>`（ユーザー）、`<@&ID>`（ロール）として利用できます。


## 実行方法

### ローカルで実行

```sh
bundle exec clockwork lib/clock.rb
```

### Dockerで実行

```sh
docker build -t sinchoku_manager .
docker run --rm sinchoku_manager
```

## テスト

```sh
bundle exec rspec
```

## ファイル構成

- `lib/clock.rb` ... スケジューラー本体
- `lib/discord_notifier.rb` ... Discord通知処理
- `lib/sinchoku_manager.rb` ... ロジック（テスト用）
- `config/settings.yml` ... ジョブ設定
- `spec/` ... RSpecテスト