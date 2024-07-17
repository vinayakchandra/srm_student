import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:srm_student/details.dart';
import 'package:srm_student/screens/loginScreen.dart';
import 'package:srm_student/screens/AttendanceScreen.dart';
import 'package:srm_student/screens/userScreen.dart';
import 'package:srm_student/screens/timeTableScreen.dart';
import 'marksScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int day = 1;
  Details dataObj = Details();

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const UserScreen(),
      TimeTableScreen(dayOrder: day),
      MarksScreen(),
      AttendanceScreen(),
    ];

    // print(dataObj.getDayOrder());

    return Scaffold(
      // backgroundColor: Colors.blue.shade300,
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.deepPurpleAccent,
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(widget.title),
        elevation: 20,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.greenAccent,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                decreaseDayOrder();
              });
            },
          ),
          Text("$day", style: const TextStyle(color: Colors.white)),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_right,
                color: Colors.greenAccent, size: 30),
            onPressed: () {
              setState(() {
                increaseDayOrder();
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Center(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(),
      drawer: buildDrawer(),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xffCBC3E3),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("Made by Vinayak"),
            accountEmail: Text("vinayak.chandra.suryavanshi@gmail.com"),
          ),
          ListTile(
            tileColor: Colors.red,
            leading: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            title: const Text(
              "Logout",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setState(() {
                print("LogOut");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Container buildBottomNavBar() {
    Color navColor = Colors.black54;
    return Container(
      color: navColor,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: GNav(
        // backgroundColor: navColor,
        activeColor: Colors.deepPurpleAccent,
        // activeColor: Colors.deepOrange,
        color: Colors.white,
        tabBackgroundColor: Colors.yellowAccent,
        padding: const EdgeInsets.all(15),
        gap: 10,
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        tabs: const [
          GButton(
            icon: Icons.person,
            text: "User",
          ),
          GButton(
            icon: Icons.watch_later,
            text: "Time Table",
          ),
          GButton(
            icon: Icons.bar_chart,
            text: "Marks",
          ),
          GButton(
            icon: Icons.show_chart,
            text: "Attendance",
          ),
        ],
      ),
    );
  }

  void increaseDayOrder() {
    setState(() {
      day = (day == 5) ? 1 : day + 1;
      dataObj.setDayOrder(day);
    });
  }

  void decreaseDayOrder() {
    setState(() {
      day = (day == 1) ? 5 : day - 1;
      dataObj.setDayOrder(day);
    });
  }
}
