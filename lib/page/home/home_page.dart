
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("首页~"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
