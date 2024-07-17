import 'package:flutter/material.dart';
import 'package:srm_student/api.dart';
import 'package:srm_student/details.dart';
import 'package:srm_student/screens/MyHomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true; // Added to track password visibility
  String? _token;
  Map<dynamic, dynamic>? details;
  Map<dynamic, dynamic>? user;
  List<dynamic>? timeTable;
  Details dataObj = Details();
  String textData = "Welcome Back!";
  Color textColor = Colors.blue;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    var studentApi = StudentApi(
      username: _usernameController.text,
      password: _passwordController.text,
    );

    _token = await studentApi.getToken();
    if (_token != 'Wrong email or password') {
      details = await studentApi.getDetails();

      dataObj.setData(details!);

      user = await details!["user"];
      timeTable = await details!["time-table"];
      // print(_timeTable);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth / 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textData,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "NetID (Before '@')",
                  prefixIcon: const Icon(Icons.mail),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await _login();
                          //token is invalid
                          if (_token == "Wrong email or password") {
                            setState(() {
                              textColor = Colors.red;
                              textData = _token as String;
                            });
                          } else {
                            //token is valid
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyHomePage(title: "SRM Student")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
