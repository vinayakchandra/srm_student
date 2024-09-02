import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PollPostScreen extends StatefulWidget {
  const PollPostScreen({super.key});

  @override
  State<PollPostScreen> createState() => _PollPostScreenState();
}

class _PollPostScreenState extends State<PollPostScreen> {
  Future<Map<String, dynamic>> getPollPost() async {
    final response = await http.get(Uri.parse(
        'https://srm-api-4.azurewebsites.net/api/post/academia/posts'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade200,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text("a.srmcheck.me",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      body: SafeArea(
        bottom: false,
        top: false,
        child: Scrollbar(
          child: FutureBuilder<Map<String, dynamic>>(
            future: getPollPost(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                var postData = snapshot.data!['postData'] as List;
                var pollData = snapshot.data!['polldata'] as List;

                // Sort the postData by date (ignoring time)
                postData.sort((a, b) {
                  DateTime dateA = _extractDate(a['postDate']);
                  DateTime dateB = _extractDate(b['postDate']);
                  return dateB.compareTo(dateA);
                });

                // Sort the pollData by date (ignoring time)
                pollData.sort((a, b) {
                  DateTime dateA = _extractDate(a['pollDate']);
                  DateTime dateB = _extractDate(b['pollDate']);
                  return dateB.compareTo(dateA);
                });

                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    if (pollData.isNotEmpty)
                      const Center(
                          child: Text('Polls',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                    ...pollData.map<Widget>((poll) {
                      // Calculate the total votes for the poll
                      final totalVotes = poll['choices']
                          .fold(0, (sum, choice) => sum + choice['votes']);
                      return pollCard(poll, totalVotes);
                    }),
                    if (postData.isNotEmpty)
                      const Center(
                          child: Text('Posts',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                    ...postData.map<Widget>((post) {
                      return postCard(post);
                    }),
                  ],
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }

  DateTime _extractDate(String dateTimeStr) {
    // Extract the date part (ignoring time) and parse it
    final datePart = dateTimeStr.split(',')[0]; // Extract "24/4/2024"
    final parts =
        datePart.split('/'); // Split "24/4/2024" into ["24", "4", "2024"]
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day); // Create DateTime object
  }

  Card postCard(post) {
    return Card(
      color: Colors.yellow.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(post['title'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(post['message'], style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.favorite, color: Colors.redAccent),
                const SizedBox(width: 4),
                Text('${post['likes'].length}',
                    style: TextStyle(color: Colors.grey.shade600)),
                const Spacer(),
                Text("@${post["name"].split(" ")[0]}",
                    style: TextStyle(color: Colors.grey.shade600)),
                const Spacer(),
                Icon(Icons.date_range, color: Colors.grey.shade600),
                Text("${post["postDate"].split(',')[0]}",
                    style: TextStyle(color: Colors.grey.shade600))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card pollCard(poll, totalVotes) {
    return Card(
      color: Colors.teal.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(poll['title'],
                      style: TextStyle(
                          color: Colors.teal.shade900,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (poll['choices'] as List).map<Widget>((choice) {
                // Calculate the percentage of votes for the current choice
                final votePercentage =
                    (totalVotes > 0) ? choice['votes'] / totalVotes : 0.0;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${choice['title']}: ${choice['votes']} votes',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: votePercentage,
                        backgroundColor: Colors.grey.shade300,
                        color: Colors.teal,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.how_to_vote, color: Colors.teal.shade700),
                const SizedBox(width: 4),
                Text('${poll['votedBy'].length}',
                    style: TextStyle(color: Colors.grey.shade600)),
                const Spacer(),
                Text("@${poll["name"].split(" ")[0]}",
                    style: TextStyle(color: Colors.grey.shade600)),
                const Spacer(),
                Icon(Icons.date_range, color: Colors.grey.shade600),
                Text("${poll["pollDate"].split(',')[0]}",
                    style: TextStyle(color: Colors.grey.shade600))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
