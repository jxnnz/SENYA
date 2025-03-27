import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "http://127.0.0.1:8000"; // Change to backend URL

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse('$baseUrl/data'),
    ); // Adjust endpoint

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
