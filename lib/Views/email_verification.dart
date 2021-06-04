import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Widgets/authentication_app_bar.dart';

const String email = "something@gmail.com";

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: authAppBar(context),
        body: Padding(
            padding: EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.mail,
                      color: Colors.grey.shade600,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Check your inbox",
                      style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 19.0,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Text(
                      "We sent a verification link to",
                      style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    ),
                    RichText(
                      text: TextSpan(
                        // text: email,
                        // style:DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(
                              text: email,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Colors.black,
                                fontFamily: 'ProximaNova',
                              )),
                          TextSpan(
                              text: '. Please check your',
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.black,
                                fontFamily: 'ProximaNova',
                              )),
                        ],
                      ),
                    ),
                    Text(
                      "email for the next step.",
                      style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      // padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      width: 360.0,
                      height: 40.0,
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Resend email",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            )),
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      child: Text("Can't access your email?",
                          style: TextStyle(
                              fontFamily: 'ProximaNova',
                              fontSize: 15.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            )));
  }
}
