import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Widgets/text_field_widget.dart';


class Occupation extends StatefulWidget {
  String occupation = '';
  Occupation({@required this.occupation});
  @override
  _State createState() => _State();
}

class _State extends State<Occupation> {
  String button = 'Edit';
  bool check = false;
  String changed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, widget.occupation),
          ),
          backgroundColor: Colors.grey[800],
          title: Text(
            "Occupation",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(button),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) => Colors.transparent),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white, width: 2.0),
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (button == 'Edit') {
                      check = true;
                      button = 'Done';
                    }
                    else
                      {
                      widget.occupation = changed;
                      check = false;
                      button = 'Edit';
                    }
                  });
                },
              ),
            ),
          ],
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only( left: 20.0, top: 7.0),
                      child: TextFormField(
                        enabled: check,
                        initialValue: widget.occupation,
                        decoration: textInputDecoration.copyWith(
                          hintText: "Add Occupation...",
                          hintStyle:
                          TextStyle(color: Colors.grey, fontSize: 23.0),
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                        ),
                        onChanged: (val) {
                          setState(() {
                            changed = val;
                          });
                        },
                      ),
                    ),
                ],
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 2.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
