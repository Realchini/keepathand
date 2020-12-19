import 'package:flutter/material.dart';

class ToDoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Список дел"),
      ),
      body: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text("rtrt"),
        value: false,
        onChanged: null,
      ),
    );
  }
}
