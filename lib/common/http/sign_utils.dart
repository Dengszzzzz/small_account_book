
import 'dart:collection';

import 'package:flustars_flutter3/flustars_flutter3.dart';

///业务需要的
class SignUtils{

  static String getSign(String url,Map<String,dynamic>? params,String key,String? t){
    //SplayTreeMap 排序
    var paramsMap = SplayTreeMap<String,dynamic>();
    if(params!=null){
      paramsMap.addAll(params);
    }
    //加入时间t
    if(t!=null){
      paramsMap["t"] = t;
    }
    //把params拆解，以key=value形式拼接，后加上秘钥key
    StringBuffer buffer = StringBuffer();
    paramsMap.forEach((entryKey, value) {
      buffer.write("$entryKey=$value");
    });
    //加入秘钥key
    buffer.write(key);
    //MD5加密：上述字符串MD5加密后，只取前7位
    String sign = EncryptUtil.encodeMd5(buffer.toString());
    if(sign.length > 7){
      sign = sign.substring(0,7);
    }
    return sign;
  }


}