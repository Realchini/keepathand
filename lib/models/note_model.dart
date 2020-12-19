class Note{
  int id, date;
  String title, content;
  //String get uniqueTag => "$date$hashCode";

  setDate() {
    DateTime now = DateTime.now();
    String dateString = now.year.toString() + now.month.toString() + now.day.toString() + now.hour.toString() + now.minute.toString() + now.second.toString();
    date = int.parse(dateString);
  }

  Note();

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    date = map['date'];
    title = map['title'];
    content = map['content'];
  }

  toMap() {
    return <String, dynamic> {
      'id': id,
      'date': date,
      'title': title,
      'content': content,
    };
  }
}