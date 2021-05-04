import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Email extends StatefulWidget {
  String visibleTo = 'Anyone';
  String email = 'Aalaasalaheldin.99@gmail.com';
  Email({@required this.email, @required this.visibleTo});
  @override
  _State createState() => _State();
}

class _State extends State<Email> {
  String button = 'Edit';
  bool check = false;
  String changed;
  List<String> data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, widget.visibleTo),
          ),
          backgroundColor: Colors.grey[800],
          title: Text(
            "Email",
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
                    } else {
                      // widget.currentCity = changed;
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
              // Stack(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 20.0, top: 7.0),
              //       child: TextFormField(
              //         enabled: check,
              //         initialValue: widget.currentCity,
              //         decoration: textInputDecoration.copyWith(
              //           hintText: "Add Current City...",
              //           hintStyle:
              //           TextStyle(color: Colors.grey, fontSize: 23.0),
              //           disabledBorder: InputBorder.none,
              //           border: InputBorder.none,
              //           focusedBorder: InputBorder.none,
              //           enabledBorder: InputBorder.none,
              //           errorBorder: InputBorder.none,
              //         ),
              //         onChanged: (val) {
              //           changed = val;
              //         },
              //       ),
              //     ),
              Container(
                color: Colors.grey[300],
                child: ListTile(
                  title: Text(widget.email),
                ),
              ),
              // ],
              // ),
              // Divider(
              //   color: Colors.grey[300],
              //   thickness: 2.0,
              // ),
              ListTile(
                  leading: Text('Visible to:'),
                  trailing: Text(widget.visibleTo),
                  onTap: () {
                    if (check == true) {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ListTile(
                                  title: Center(
                                    child: Text(
                                      'Visible to:',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                  thickness: 2.0,
                                ),
                                ListTile(
                                  title: Text('Anyone',
                                      style:
                                          TextStyle(color: Colors.grey[900])),
                                  onTap: () {
                                    setState(() {
                                      widget.visibleTo = 'Anyone';
                                      // data = [currentCity, visibleTo];
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                  thickness: 2.0,
                                ),
                                ListTile(
                                  title: Text('Any Flickr member',
                                      style:
                                          TextStyle(color: Colors.grey[900])),
                                  onTap: () {
                                    setState(() {
                                      widget.visibleTo = 'Any Flickr member';
                                      Navigator.pop(
                                          context, 'Any Flickr member');
                                    });
                                  },
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                  thickness: 2.0,
                                ),
                                ListTile(
                                  title: Text('People you follow',
                                      style:
                                          TextStyle(color: Colors.grey[900])),
                                  onTap: () {
                                    setState(() {
                                      widget.visibleTo = 'People you follow';
                                      Navigator.pop(
                                          context, 'People you follow');
                                    });
                                  },
                                ),
                                Divider(
                                  color: Colors.grey[300],
                                  thickness: 2.0,
                                ),
                                ListTile(
                                  title: Text('Friends and family',
                                      style:
                                          TextStyle(color: Colors.grey[900])),
                                  onTap: () {
                                    setState(() {
                                      widget.visibleTo = 'Friends and family';
                                      Navigator.pop(
                                          context, 'Friends and family');
                                    });
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  }),
              //
              // Divider(
              //   color: Colors.grey[300],
              //   thickness: 2.0,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
