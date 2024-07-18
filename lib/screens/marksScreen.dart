import 'package:flutter/material.dart';
import 'package:srm_student/details.dart';

class MarksScreen extends StatelessWidget {
  final Details dataObj = Details();

  @override
  Widget build(BuildContext context) {
    List<dynamic> marksData = dataObj.getData()['internal_marks'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: marksData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: (marksData[index]['category'] == ("Practical"))
                ? Colors.lightGreenAccent
                : Colors.yellow.shade300,
            // margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    marksData[index]['subject_code'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.category, color: Colors.black54),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Category: ${marksData[index]['category']}',
                          style: const TextStyle(
                            // fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.numbers, color: Colors.black54),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Marks: ${marksData[index]['marks'].isEmpty ? '-' : marksData[index]['marks'][0]}',
                          style: const TextStyle(
                            // fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
