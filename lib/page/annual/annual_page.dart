
import 'package:flutter/material.dart';

class AnnualPage extends StatefulWidget {
  const AnnualPage({Key? key}) : super(key: key);

  @override
  State<AnnualPage> createState() => _AnnualPageState();
}

class _AnnualPageState extends State<AnnualPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("年度~"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
