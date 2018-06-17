# mikutter_pushbullet
## これなん
mikutterのMentionとFavoriteとRetweetイベントをPushbulletで通知します．

## インストール
```sh
$ mkdir -p ~/.mikutter/plugin
$ cd ~/.mikutter/plugin/
$ git clone https://github.com/yuzumone/mikutter_pushbullet.git
```

## 使い方
アクセストークンのみを設定した場合，すべてのデバイスに通知を送ります．  
デバイスのIDも設定した場合，設定した端末にのみ通知を送ります．  
アクセストークンはPushbulletの設定画面で確認できます．  
デバイスIDは以下のコマンド実行で確認してください．
```sh
$ curl -u Your_Token: https://api.pushbullet.com/v2/devices
```
JSONが帰ってくるので"iden":に続く文字列がデバイスIDです．  
取得したものをmikutterの設定画面で入力してください．
