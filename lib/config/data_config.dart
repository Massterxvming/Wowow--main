import 'dart:convert';

import 'package:encrypt/encrypt.dart';

class ConfigEncryption {
  static final _originalConfig = {
    'accessIdKey':"kLH4AWd3KoDKxkctcfqRiXyWordyUDwj2LktRsVtBwEuCGnvL"
  };
  static final key = Key.fromUtf8('PGATYSUDYHNXHAKJSHJKSHJKLSGKHFGA');
  static final iv = IV.fromLength(16);

  static String encryptConfig(Map<String, dynamic> config) {
    final encrypter = Encrypter(AES(key));
    final encryptedData = encrypter.encrypt(json.encode(config), iv: iv);
    return encryptedData.base64;
  }
  static final _encryptedConfig=encryptConfig(_originalConfig);
  // 解密配置文件
  static Map<String, dynamic> decryptConfig() {
    final encrypter = Encrypter(AES(key));//加密一个key值
    final decryptedData = encrypter.decrypt64(_encryptedConfig, iv: iv);
    return json.decode(decryptedData);//json.decode=Map<String,dynamic>
  }
  _getAccessKey(){
    return decryptConfig();
  }
}

