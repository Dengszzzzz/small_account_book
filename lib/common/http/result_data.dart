/// 网络结果数据
class ResultData {
  int code = -1;
  String message = "";
  dynamic data;

  ResultData(this.code, this.message, this.data);

  ResultData.fromJson(Map<String, dynamic> json){
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }

  Map<String,dynamic> toJson()=><String,dynamic>{
    'code':code,
    'message':message,
    'data':data
  };

  //状态码=200，业务逻辑成功
  bool isSuccess()=> code == 200;
}
