class ToDo{
  int id, date;
  String title;
  bool value;
  //String get uniqueTag => "$date$hashCode";

  setDate() {
    DateTime now = DateTime.now();
    String dateString = now.year.toString() + now.month.toString() + now.day.toString() + now.hour.toString() + now.minute.toString() + now.second.toString();
    date = int.parse(dateString);
  }

  ToDo();

  bool intToBool(int a) => a == 0 ? false : true;
  int boolToInt(bool a) => a == false ? 0 : 1;

  ToDo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    date = map['date'];
    title = map['title'];
    value = intToBool(map['value']);
  }

  toMap() {
    return <String, dynamic> {
      'id': id,
      'date': date,
      'title': title,
      'value': boolToInt(value),
    };
  }
}