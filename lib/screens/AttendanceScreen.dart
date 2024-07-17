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

  CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3,
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
                const Icon(
                  Icons.code,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Text(
                  'Subject Code: ${course['subject_code']}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Text(
                  'Faculty: ${course['subject_faculty']}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.category,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Text(
                  'Category: ${course['category']}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.schedule,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Text(
                  'Slot: ${course['slot']}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.timer,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Text(
                  'Conducted Hours: ${course['conducted_hours']}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.hourglass_empty,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Text(
                  'Absent Hours: ${course['absent_hours']}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.date_range,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Text(
                  'Practical Date: ${course['practical_date']}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.black54,
                ),
                const SizedBox(width: 10),
                Text(
                  'Practical Time: ${course['practical_time']}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
