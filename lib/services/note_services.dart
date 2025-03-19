import 'dart:convert';
import 'package:note_pad_app/models/note.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const String baseUrl = "http://10.0.2.2";

  static Future<List<Note>> getNotes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/notes'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Note.fromJson(json)).toList();
      } else {
        throw Exception("Failed to get data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }

  static Future<void> addNote(String title, String content) async {
    await http.post(
      Uri.parse('$baseUrl/notes'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {"title": title, "content": content},
    );
  }
}
