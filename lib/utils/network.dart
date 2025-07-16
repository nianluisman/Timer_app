import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/event.dart';

Future<void> sendEvent(Event event) async {
  final response = await http.post(
    Uri.parse('http://your-ddns-name:5000/event'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(event.toJson()),
  );

  if (response.statusCode == 200) {
    print("Event sent successfully: ${response.body}");
  } else {
    print("Failed to send event: ${response.statusCode}");
  }
}
