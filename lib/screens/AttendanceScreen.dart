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
    double presentPercentage =
        conductedHours > 0 ? (present / conductedHours) * 100 : 0;

    // Calculate threshold margin for 75% attendance
    double threshold = conductedHours * 0.75;
    int margin =
        present - threshold.ceil();

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
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  course['subject_code'],
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "Margin: ",
                  style: TextStyle(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "$margin",
                  style: TextStyle(
                    color: Colors.orange.shade800,
                  ),
                ),
                const Spacer(),
                Text(
                  "${presentPercentage.toStringAsFixed(2)}%",
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                _buildInfoColumn(
                    "Total", course['conducted_hours'], Colors.teal.shade800),
                const SizedBox(width: 10),
                _buildInfoColumn(
                    "Abs", course['absent_hours'], Colors.red.shade900),
                const SizedBox(width: 10),
                _buildInfoColumn("Present", "$present", Colors.green.shade800),
                const SizedBox(width: 10),
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
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: textColor),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
          ),
        ),
      ],
    );
  }
}
