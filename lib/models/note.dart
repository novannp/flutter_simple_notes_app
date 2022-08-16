class NoteModel {
  int? id;
  String? title;
  String? body;
  DateTime? creationDate;

  NoteModel({
    this.id,
    this.title,
    this.body,
    this.creationDate,
  });

  //convert Item to Map

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'creationDate': creationDate.toString()
    };
  }
}
