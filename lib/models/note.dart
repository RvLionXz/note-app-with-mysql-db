class Note {
  int id;
  String title;
  String content;
  String? createdAt;

  // Konstruktor
  Note({required this.id, required this.title, required this.content, this.createdAt});

  // Factory method untuk membuat instance Note dari JSON
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      createdAt: json["created_at"],
    );
  }
}
