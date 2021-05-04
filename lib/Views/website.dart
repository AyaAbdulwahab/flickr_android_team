// import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flickr/Views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Website extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Website> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text("Website", style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Edit'),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => Colors.transparent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 2.0),
                  ),
                ),
              ),
              onPressed: () {
              },
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(title: Padding(
              padding: const EdgeInsets.fromLTRB(8.0,15.0,8.0,10.0),
              child: Text('Add Website...', style: TextStyle(color: Colors.grey, fontSize: 23.0),),
            ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
