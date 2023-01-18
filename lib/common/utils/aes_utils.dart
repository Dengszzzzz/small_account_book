
import 'package:encrypt/encrypt.dart';

import '../config/config.dart';

class AESUtils{


  ///aes加密函数(AES/CBC/PKCS5Padding)
  static String aesEncrypt(String data,{String keyStr = Config.aesEncryptKey,String ivStr = Config.aesEncryptIv}) {
    var key = Key.fromUtf8(keyStr);
    var iv = IV.fromUtf8(ivStr);
    //AES/CBC/PKCS5Padding
    /// PKCS5 是 PKCS7的子集，PKCS7兼容PKCS5，https://blog.csdn.net/boweiqiang/article/details/109860950
    var encrypter = Encrypter(AES(key,mode: AESMode.cbc,/*padding: 'PKCS5Padding'*/));
    var encrypted = encrypter.encrypt(data, iv: iv);
   // print("AES加密：${encrypted.base64}");
    return encrypted.base64;
  }

  ///aes解密
  static String aesDecrypt(String data,{String keyStr = Config.aesEncryptKey,String ivStr = Config.aesEncryptIv}) {
    var key = Key.fromUtf8(keyStr);
    var iv = IV.fromUtf8(ivStr);
    //AES/CBC/PKCS5Padding
    var encrypter = Encrypter(AES(key,mode: AESMode.cbc,/*padding: 'PKCS5Padding'*/));
    //解密
    var decrypted = encrypter.decrypt(Encrypted.fromBase64(data), iv: iv);
  //  print("AES解密：$decrypted");
    return decrypted;
  }
}