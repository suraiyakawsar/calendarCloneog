import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'event_editing_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//this class is where every widget is implemented and built, any methods, etc.
class _HomePageState extends State<HomePage> {
  //initialize variables here ...
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(),
        body: buildBody(),
        bottomNavigationBar: buildBotBar(),
      );

  AppBar buildAppBar() => AppBar(
        title: const Text('Schedule'),
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.all(9.0),
          child: CircleAvatar(
            backgroundColor: Colors.redAccent,
            child: Text(
              "VC",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: [
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // addEvent();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      );

  Widget buildBody() => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SfCalendar(
            view: CalendarView.month,
            // monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
            showNavigationArrow: true,
            allowedViews: const [CalendarView.day, CalendarView.week, CalendarView.workWeek, CalendarView.month, CalendarView.schedule],
            cellBorderColor: Colors.transparent,
            // allowViewNavigation: true,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventEditingPage())),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget buildBotBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_copy),
          label: 'Docs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Assessment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }


}
//add everything before this curly
