import 'package:flutter/material.dart';
import 'package:srm_student/details.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Details dataObj = Details();

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> user = dataObj.getData()["user"];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        user["name"],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    UserInfoTile(
                      icon: Icons.school,
                      label: 'Program',
                      value: user["program"],
                    ),
                    const Divider(),
                    UserInfoTile(
                      icon: Icons.account_balance,
                      label: 'Department',
                      value: user["department"],
                    ),
                    const Divider(),
                    UserInfoTile(
                      icon: Icons.book,
                      label: 'Spec',
                      value: user["spec"],
                    ),
                    const Divider(),
                    UserInfoTile(
                      icon: Icons.badge,
                      label: 'Reg No',
                      value: user["regNo"],
                    ),
                    const Divider(),
                    UserInfoTile(
                      icon: Icons.group,
                      label: 'Section',
                      value: user["section"],
                    ),
                    const Divider(),
                    UserInfoTile(
                      icon: Icons.calendar_today,
                      label: 'Sem',
                      value: user["sem"],
                    ),
                    const Divider(),
                    UserInfoTile(
                      icon: Icons.date_range,
                      label: 'Batch',
                      value: user["batch"],
                    ),
                    const Divider(),
                    UserInfoTile(
                      icon: Icons.phone,
                      label: 'Number',
                      value: user["number"],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const UserInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      leading: Icon(
        icon,
        color: Colors.teal,
      ),
      title: Text(
        '$label: ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
