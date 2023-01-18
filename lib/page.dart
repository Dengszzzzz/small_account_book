import 'package:get/get.dart';

import 'page/main_page.dart';
///注册路由表
List<GetPage> pages = [
  GetPage(name: '/main', page: () => const MainPage()),
];