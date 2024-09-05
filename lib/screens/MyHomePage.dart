import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(widget.title),
        elevation: 20,
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
      backgroundColor: Colors.orange.shade50,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrangeAccent,
            ),
            accountName: Text("Made by Vinayak"),
            accountEmail: Text("vinayak.chandra.suryavanshi@gmail.com"),
          ),
          ListTile(
            tileColor: Colors.red,
            leading: const Icon(Icons.exit_to_app, color: Colors.white),
            title: const Text(
              "Logout",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              setState(() {
                prefs.clear();
                debugPrint("Logout");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
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
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 25),
      child: GNav(
        activeColor: Colors.teal.shade800,
        color: Colors.white,
        tabBackgroundColor: Colors.orangeAccent.shade100,
        padding: const EdgeInsets.all(15),
        gap: 10,
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        tabs: [
          GButton(
            icon: _selectedIndex == 0 ? Icons.person : Icons.person_outline,
            text: "User",
          ),
          GButton(
            icon: _selectedIndex == 1
                ? Icons.watch_later
                : Icons.watch_later_outlined,
            text: "Time Table",
          ),
          GButton(
            icon: _selectedIndex == 2
                ? Icons.assessment
                : Icons.assessment_outlined,
            text: "Marks",
          ),
          GButton(
            icon: _selectedIndex == 3
                ? Icons.event_available
                : Icons.event_available_outlined,
            text: "Attendance",
          ),
        ],
      ),
    );
  }
}
