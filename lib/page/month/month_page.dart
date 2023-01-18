
import 'package:flutter/material.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({Key? key}) : super(key: key);

  @override
  State<MonthPage> createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("月度~"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
