# build
- make key.jks
```shell
cd android/app
keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key0 -storetype jks# 密码123456
```