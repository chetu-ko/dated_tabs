import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  List<Widget> myTabs;
  List<Widget> tabView = List<Widget>();
  List<DateTime> tabDate = [];
  TabController tabController;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  TabController getTabController() {
    return TabController(length: 0, vsync: this);
  }

  void initState() {
    tabController = getTabController();
    super.initState();
  }

  Widget getWidget(DateTime widgetNumber) {
    return Center(
      child: Text("Date: $widgetNumber"),
    );
  }

  List<Widget> getWidgets() {
    tabView.clear();

    tabView = List.generate(tabDate.length, (index) {
      return getWidget(tabDate[index]);
    });

    tabDate.clear();
    return tabView;
  }

  @override
  Widget build(BuildContext context) {
    final myTabs = List.generate(7, (index) {
      var now = selectedDate;
      var date = DateTime(now.year, now.month, now.day + index);
      var day = DateFormat('d').format(date);
      var week = DateFormat('EEEE').format(date);
      var weekname = week.substring(0, 3);
      var month = DateFormat('MMMM').format(date).substring(0, 3);
      tabDate.add(date);

      return Column(
        children: [
          Text(weekname),
          Text(
            day.toString() + ' ' + month,
            style: TextStyle(fontSize: 10),
          ),
        ],
      );
    });
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: myTabs,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.date_range),
              onPressed: () => _selectDate(context),
            )
          ],
          title: Text("Matches"),
        ),
        body: TabBarView(
          children: getWidgets(),
        ),
      ),
    );
  }
}
