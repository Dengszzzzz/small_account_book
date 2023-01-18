import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Flutter 全能型选手GetX —— 路由管理  https://blog.csdn.net/hjjdehao/article/details/126270895
void toPage(Widget page, {bool opaque = false}) {
  //注意这两种区别，推荐使用后者，这也是官方推荐的，因为后者将controller的生命周期和widget绑定起来。
  //Get.to(page);
  Get.to(() => page, opaque: opaque);
}

void toNamed(String page, {dynamic arguments}) {
  Get.toNamed(page, arguments: arguments);
}

void back({dynamic result}) {
  Get.back(result:result);
}

dynamic arguments() {
  return Get.arguments;
}

//跳转到下个页面，会关闭上个页面。
void offNamed(String page,{dynamic arguments}){
  Get.offNamed(page,arguments: arguments);
}

//跳转到下个页面，关闭除它之外的所有页面。
void offAllNamed(String page,{dynamic arguments}){
  Get.offNamed(page,arguments: arguments);
}

//按次序移除其他的路由，直到遇到被标记的路由（predicate函数返回了true）时停止。若 没有标记的路由，则移除全部。当路由栈中存在重复的标记路由时，默认移除到最近的一个停止。
void offUntil(String page,RoutePredicate predicate,{dynamic arguments}){
  Get.offNamedUntil(page,predicate,arguments: arguments);
}


/// ----------------------------   跳转    ------------------------------  ///
//跳转主页
void toMainPage(){
  offAllNamed('/main');
}

//跳转登录页
void toLoginPage(int type){
  toNamed('/login',arguments: type);
}

//跳转登录选择页
void toLoginTypePage(){
  //loginRepository.logout();
  offAllNamed('/loginType');
}

//跳转忘记密码页
void toForgetPwdPage(){
  toNamed('/forgetPwd');
}

//跳转网页
void toWebViewPage(String url){
  toNamed('/webView',arguments: url);
}

//跳转完善个人信息页
void toCompleteUserInfoPage(){
  toNamed('/completeUserInfo');
}

//跳转修改个人信息页
void toModifyUserInfoPage(){
  toNamed('/modifyUserInfo');
}
//跳转设置页
void toSettingPage(){
  toNamed('/settingPage');
}
//跳转闲聊大厅
void toChatHallPage(){
  toNamed('/chatHallPage');
}

