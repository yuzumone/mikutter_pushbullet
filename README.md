# mikutter_pushbullet
## これなん
mikutterのMentionとFavoriteとRetweetイベントをPushbulletで通知します．

## インストール
cloneしたら
```sh
$ cd ~/.mikutter/plugin/
$ git clone https://github.com/yuzumone/mikutter_pushbullet
```
PushbulletのAPIを使うのにwashbulletを使っているので
```sh
$ gem install washbullet
```
とかもしてください．

## 使い方
アクセストークンと通知を送るデバイスのIDが必要です．  
アクセストークンはPushbulletの設定画面で確認できます．  
デバイスIDは以下のコマンド実行で確認してください．
```sh
$ curl -u Your_Token: https://api.pushbullet.com/v2/devices
```
JSONが帰ってくるので"iden":に続く文字列がデバイスIDです．  
取得したものをmikutterの設定画面で入力してください．