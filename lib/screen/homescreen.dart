import 'package:flutter/material.dart';
import 'package:tab_date/widget/dated_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MainScreen());
  }
}
