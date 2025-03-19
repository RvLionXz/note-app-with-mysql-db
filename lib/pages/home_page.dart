import 'package:flutter/material.dart';
import 'package:note_pad_app/models/note.dart';
import 'package:note_pad_app/services/note_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  bool loading = false;

  void fetchNotes() async {
    loading = true;
    final result = await NoteService.getNotes();
    notes = result;
    print(result);
    setState(() {});
    loading = false;
  }

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Note App",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
        body:
            loading
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                )
                : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return Card(child: ListTile(title: Text(note.toString())));
                  },
                ),
      ),
    );
  }
}
