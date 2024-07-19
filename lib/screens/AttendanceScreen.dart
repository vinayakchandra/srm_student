import 'package:flutter/material.dart';
import '../details.dart';

class AttendanceScreen extends StatelessWidget {
  Details dataObj = Details();

  @override
  Widget build(BuildContext context) {
    final List<dynamic> courses = dataObj.getData()["courses"];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseCard(course: courses[index]);
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;
  Color textColor = Colors.black54;

  CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    int conductedHours = int.tryParse(course['conducted_hours']) ?? 0;
    int absentHours = int.tryParse(course['absent_hours']) ?? 0;
    int present = conductedHours - absentHours;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: course['category'] == 'Practical'
          ? Colors.lightGreenAccent
          : Colors.yellow.shade300,
      // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              course['subject_name'],
              style: const TextStyle(
                // fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                course['subject_code'],
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: Colors.teal.shade800,
                      ),
                    ),
                    Text(
                      course['conducted_hours'],
                      style: TextStyle(
                        color: Colors.teal.shade800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      "Abs",
                      style: TextStyle(
                        color: Colors.red.shade900,
                      ),
                    ),
                    Text(
                      course['absent_hours'],
                      style: TextStyle(
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Text(
                      "Present",
                      style: TextStyle(
                        color: Colors.green.shade800,
                      ),
                    ),
                    Text(
                      "$present",
                      style: TextStyle(
                        color: Colors.green.shade800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          _buildRow(Icons.code, 'Subject Code: ${course['subject_code']}'),
          _buildRow(Icons.person, 'Faculty: ${course['subject_faculty']}'),
          _buildRow(Icons.category, 'Category: ${course['category']}'),
          _buildRow(Icons.schedule, 'Slot: ${course['slot']}'),
          _buildRow(
              Icons.timer, 'Conducted Hours: ${course['conducted_hours']}'),
          _buildRow(
              Icons.hourglass_empty, 'Absent Hours: ${course['absent_hours']}'),
          _buildRow(
              Icons.date_range, 'Practical Date: ${course['practical_date']}'),
          _buildRow(
              Icons.access_time, 'Practical Time: ${course['practical_time']}'),
          _buildRow(
              Icons.numbers, 'Internal Marks: ${course['internal_marks']}'),
        ],
      ),
    );
  }

  Widget _buildRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
