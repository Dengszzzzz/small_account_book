
class Config{

  ///网络请求用到
  static const String desKey = "";
  static const String aesEncryptKey = "";
  static const String aesEncryptIv = "";
  ///DES加解密用到(key只能8个byte)
  static const String pwdDesKey = "1ea53d26";
  static const String giftCarDesKey = "MIIBIjAN";

  ///密码的最大数量
  static const int pwd_count = 16;
  ///密码正则表达式规则，但那些符号不一定有用
  static const String digits = "0-9a-zA-Z\~\`\!\@\#\$\^\*\(\)\-\_\+\=\>\,\.\>\?\/\;\:\\\'\"";

  /// userAgent
  static const String USER_AGENT = "yumengAppAndroid";
  /// JavascriptInterfaceName
  static const String JSInterfaceName = "androidJsObj";

  ///男女性别
  static const int SEX_MALE = 1;
  static const int SEX_FEMALE = 2;

  static const int PAGE_START = 1;
  static const int PAGE_SIZE = 10;
  static const int PAGE_HOME_HOT_SIZE = 100;
  static const int PAGE_NORMAL_SIZE = 100;
}

class SpKey{
  static const String init = "init";
  static const String accountInfo = "accountInfo";
  static const String ticketInfo = "ticketInfo";
  static const String isAgreePrivacyPolicy = "isAgreePrivacyPolicy";
}
