import 'package:flutter/material.dart';
import 'package:flutter_app_test/resources/app_strings.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _contacts = [];
  static const maxMockContacts = 100;

  void _generateList() {
    for(int i=0; i <= maxMockContacts; i++) {
      _contacts.add("Contact #$i");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _generateList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _contacts.map(_buildTextContainer).toList(),
        ),
      )
    );
  }

  Widget _buildTextContainer(String contactName) {
    return Container(
      width: double.infinity,
      //height: double.infinity, // DP
      color: Colors.lightBlue,
      padding: EdgeInsets.all(18),
      child: Text (contactName),
    );
  }
}