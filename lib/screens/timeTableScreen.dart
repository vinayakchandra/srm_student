import 'package:flutter/material.dart';
import '../details.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key, required this.dayOrder}) : super(key: key);

  final int dayOrder;

  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  Details dataObj = Details();
  double _currentSliderValue = 1.0; // Initial slider value

  @override
  Widget build(BuildContext context) {
    final List<dynamic> timeTableData = dataObj.getData()["time-table"];
    Map<String, dynamic> dayTimeTable = timeTableData[(_currentSliderValue.toInt() - 1)];

    return ListView(
      // padding: const EdgeInsets.all(16.0),
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              'Day Order: ${dayTimeTable['day_order']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Slider(
          activeColor: Colors.teal.shade800,
          value: _currentSliderValue,
          min: 1,
          max: 5,
          divisions: 4, // 4 intervals between 1 to 5 (inclusive)
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
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
