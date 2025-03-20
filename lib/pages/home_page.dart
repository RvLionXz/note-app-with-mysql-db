import 'package:flutter/material.dart';
import 'package:note_pad_app/models/note.dart';
import 'package:note_pad_app/services/note_services.dart';
import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  bool loading = true;

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
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            debugPrint("Card Tap");
                          },
                          child: ListTile(
                            title: Text(
                              note.title,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(note.content, maxLines: 2),
                            trailing: IconButton(
                              onPressed: () async {
                                await NoteService.deleteNotes(note.id);
                                fetchNotes();
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotePages()),
            );
          },
          backgroundColor: Colors.blue,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
