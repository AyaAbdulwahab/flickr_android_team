import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserOptions extends StatefulWidget {
  @override
  _UserOptionsState createState() => _UserOptionsState();
}

class _UserOptionsState extends State<UserOptions> {
  final int noOfPhotos = 0;

  final int limit = 1000;
  List<String> options;

  final List<Function> optionsActions = [() {}, () {}, () {}, () {}];
  @override
  void initState() {
    super.initState();

    options = [
      'Join Pro',
      'Using ${noOfPhotos.toString()} of ${limit.toString()} photos',
      'Edit Profile Photo',
      'Edit Cover Photo'
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 11.0),
        separatorBuilder: (context, index) => Divider(
              color: Colors.grey[300],
              thickness: 2,
              indent: 20.0,
              endIndent: 20.0,
            ),
        itemCount: options.length,
        itemBuilder: (context, index) => ListTile(
              onTap: () => optionsActions[index],
              minVerticalPadding: 10.0,
              title: Center(
                child: index == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.crown,
                            color: Colors.blue[700],
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Join Pro',
                            style: TextStyle(color: Colors.blue[700]),
                          ),
                        ],
                      )
                    : Text(
                        options[index],
                        style: TextStyle(
                            fontWeight: index != 1
                                ? FontWeight.w700
                                : FontWeight.normal,
                            fontFamily: 'ProximaNova'),
                      ),
              ),
            ));
  }
}
