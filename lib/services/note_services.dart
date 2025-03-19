import 'dart:convert';
import 'package:note_pad_app/models/note.dart';
import 'package:http/http.dart' as http;

class NoteService {
  static const String url = "http://10.0.2.2:5000";

  // Fungsi untuk mengambil data dari API
  static Future<List<Note>> getNotes() async {
    final response = await http.get(Uri.parse("$url/notes"));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<Note> posts = jsonData.map((data) => Note.fromJson(data)).toList();
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // Fungsi untuk menambahkan data
  static Future<void> createNotes(String title, String content) async {
    final response = await http.post(
      Uri.parse("$url/notes"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"title": title, "content": content}),
    );

    if (response.statusCode == 200) {
      print("Data Berhasil Ditambahkan");
    } else {
      print("Response body: ${response.body}");
    }
  }
  
  // Fungsi Menghapus Data
  static Future<void> deleteNotes(int id) async {
    final response = await http.delete(Uri.parse("$url/notes/$id"));

    if (response.statusCode == 200) {
      print("Note has been deleted");
    }else {
      print(response.body);
    }
  }
}

