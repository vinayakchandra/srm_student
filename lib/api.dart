import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentApi {
  final String username;
  final String password;
  String? token;
  Map<dynamic, dynamic>? details;

  StudentApi({required this.username, required this.password});

  Future<String?> getToken() async {
    var url = Uri.parse('https://academia-s-3.azurewebsites.net/login');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      // print("body = $responseBody");
      if (responseBody != null) {
        // token = "Wrong email or password";
        if (responseBody["token"] != null) {
          //valid and token is there
          token = responseBody['token'];
          print('Login successful');
        } else {
          //invalid email/password
          token = responseBody["message"];
          print(token);
          print('Login not successful');
        }
      }
    } else {
      print('Login failed with status: ${response.statusCode}');
    }

    return token;
  }

  Future<Map<dynamic, dynamic>?> getDetails() async {
    var url = Uri.parse('https://academia-s-2.azurewebsites.net/course-user');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "X-Access-Token": token!,
      },
    );

    if (response.statusCode == 200) {
      details = jsonDecode(response.body);
      print('Request was successful');
      // print('Response body: ${response.body}');
      print(details!["user"]);
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    return details;
  }

  Future<Map<dynamic, dynamic>?> getDayOrder() async {
    var url = Uri.parse('https://academia-s-3.azurewebsites.net/do');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      details = jsonDecode(response.body);
      print('DayOrder: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    return details;
  }

  Future<Map<dynamic, dynamic>> getPollPost() async {
    final response = await http.get(Uri.parse(
        'https://srm-api-4.azurewebsites.net/api/post/academia/posts'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

void main() async {
  StudentApi(username: '', password: "").getDayOrder();
}
