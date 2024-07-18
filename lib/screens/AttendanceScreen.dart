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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: course['category'] == 'Practical'
          ? Colors.lightGreenAccent
          : Colors.yellow.shade300,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                course['subject_name'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.code,
                  color: textColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Subject Code: ${course['subject_code']}',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: textColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Faculty: ${course['subject_faculty']}',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.category,
                  color: textColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Category: ${course['category']}',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: textColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Slot: ${course['slot']}',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.timer,
                  color: textColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Conducted Hours: ${course['conducted_hours']}',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.hourglass_empty,
                  color: textColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Absent Hours: ${course['absent_hours']}',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.date_range,
                  color: textColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Practical Date: ${course['practical_date']}',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: textColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Practical Time: ${course['practical_time']}',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.numbers,
                  color: textColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Internal Marks: ${course['internal_marks']}',
                  style: TextStyle(color: textColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
