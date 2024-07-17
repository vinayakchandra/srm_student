import 'package:flutter/material.dart';
import '../details.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key, required this.dayOrder});

  final int dayOrder;

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  Details dataObj = Details();

  @override
  Widget build(BuildContext context) {
    final List<dynamic> timeTableData = dataObj.getData()["time-table"];
    Map<String, dynamic> dayTimeTable = timeTableData[widget.dayOrder - 1];
    // print("\nTimeTable=\n ${dayTimeTable}");
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              'Day Order: ${dayTimeTable['day_order']}',
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        for (var entry in dayTimeTable.entries)
          if (entry.key != 'day_order') ...[
            Card(
              color: (entry.value[0].toString().contains("Lab"))
                  ? Colors.lightGreenAccent
                  : Colors.yellow.shade300,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(entry.value[0]),
                subtitle: Text(entry.key),
              ),
            ),
          ],
      ],
    );
  }
}
