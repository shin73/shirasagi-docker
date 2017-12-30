
## shirasagiを直下にcloneする

## shirasagiのDB設定を変える

```
--- a/config/samples/mongoid.yml
+++ b/config/samples/mongoid.yml
@@ -7,7 +7,7 @@ production:
     default:
       database: ss
       hosts:
-        - localhost:27017
+        - mongodb:27017

@@ -7,7 +7,7 @@ development:
     default:
       database: ss
       hosts:
-        - localhost:27017
+        - mongodb:27017

```


## docker-composeでビルドして起動
```
docker-compose up --build
```

## サンプルデータを入れる（ローカルで実行する）
```
sh etc/init.sh
```

## ブラウザで確認する
http://localhost:3000
