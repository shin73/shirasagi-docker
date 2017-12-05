
shirasagiを直下にcloneする

shirasagiのDB設定を変える

```
--- a/config/samples/mongoid.yml
+++ b/config/samples/mongoid.yml
@@ -7,7 +7,7 @@ production:
     default:
       database: ss
       hosts:
-        - localhost:27017
+        - mongodb:27017
```
