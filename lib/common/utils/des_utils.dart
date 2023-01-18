
import 'dart:convert';

import 'package:dart_des/dart_des.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';

import '../config/config.dart';
import 'log_utils.dart';

class DESUtils{

  ///这个App，DES加解密模式是ECB、填充是PKCS5
  static const DESMode _mode = DESMode.ECB;
  static const DESPaddingType _paddingType = DESPaddingType.PKCS5;

  ///Des加密后用Base64编码
  static String desAndBase64Encrypt(String data){
    var encrypted = _desEncrypt(data, Config.pwdDesKey);
    var dataBase64 = base64Encode(encrypted);
    logD('DES Base64加密结果：$dataBase64');
    return dataBase64;
  }

  static String decryptPwd(String dataBase64){
    return desAndBase64Decrypt(dataBase64,Config.pwdDesKey);
  }

  static String decryptSvg(String dataBase64){
    return desAndBase64Decrypt(dataBase64,Config.giftCarDesKey);
  }

  ///DES解密前，用Base64解码
  static String desAndBase64Decrypt(String dataBase64,String key){
    if (ObjectUtil.isEmptyString(dataBase64)) return "";
    List<int> encryptedData = base64Decode(dataBase64);
    String result = _desDecrypt(encryptedData, Config.pwdDesKey);
    logD('DES Base64解密结果：$result');
    return result;
  }

  ///DES加密
  static List<int> _desEncrypt(String data,String key){
    //秘钥，转为int数组,DES的秘钥只能是8个字节
    List<int> keyBytes = utf8.encode(key).getRange(0, 8).toList();
    //DES加密(三个参数分别是key、模式、填充，在和其他平台对接的时注意这几个参数是否一致)
    DES desECB = DES(key: keyBytes, mode: _mode,paddingType: _paddingType);
    //将data转为utf-8，int数组
    List<int> dataBytes = utf8.encode(data);
    //加密
    var encrypted = desECB.encrypt(dataBytes);
    return encrypted;
  }

  ///DES解密
  static String _desDecrypt(List<int> encrypted,String key){
    List<int> keyBytes = utf8.encode(Config.pwdDesKey).getRange(0, 8).toList();
    DES desECB = DES(key: keyBytes, mode: _mode,paddingType: _paddingType);
    List<int> decryptedData = desECB.decrypt(encrypted);
    String result = utf8.decode(decryptedData);
    return result;
  }


}