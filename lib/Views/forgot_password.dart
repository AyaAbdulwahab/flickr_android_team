import 'package:flickr/View_Model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Widgets/authentication_app_bar.dart';
import 'dart:convert';

const String email = "something@gmail.com";

//TODO: initialize _email with passed string from login page

/// The [ForgotPassword] page is where user enters their email to send an email for instructions on how to reset their password
class ForgotPassword extends StatefulWidget {
  String email;
  ForgotPassword(this.email);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email = "";
  bool _invalidAlert = false;
  final _formKey = GlobalKey<FormState>();

  sendEmail() async {
    var response = await forgotPassword(_email);
    // var responseBody = jsonDecode(response.data);
    if (response.statusCode == 200) {
      print("Navigate");
      //TODO: Navigate to email_verification page
    } else {
      setState(() {
        _invalidAlert = true;
      });
      print("Invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    _email = widget.email;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: authAppBar(context),
        body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.mail,
                          color: Colors.grey.shade600,
                          size: 30.0,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Change your Flickr password",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'ProximaNova',
                                fontSize: 19.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 7.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Please enter your email address below and",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'ProximaNova',
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "we'll send you instructions on how to reset your",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'ProximaNova',
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "password.",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'ProximaNova',
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Visibility(
                          visible: _invalidAlert,
                          child: Container(
                            width: 370.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                border: Border.all(
                                  color: Colors.red[100],
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Center(
                              child: Text(
                                "Invalid email or password",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: 360,
                          // height:50,
                          // padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: TextFormField(
                            initialValue: _email,
                            key: Key("forgot-pass-field"),
                            onChanged: (email) {
                              setState(() {
                                _email = email;
                                _invalidAlert = false;
                              });
                            },
                            onFieldSubmitted: (email) {
                              if (_formKey.currentState.validate()) {}
                              setState(() {
                                if (_email != "") {
                                  sendEmail();
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              });
                            },
                            validator: (val) => val.isEmpty ? "Required" : null,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                labelText: 'Email address',
                                // labelStyle: style,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.0)),
                                  borderSide: BorderSide(color: Colors.pink),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          // padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          width: 360.0,
                          height: 40.0,
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {}
                              //TODO: Request
                              if (_email != "") {
                                sendEmail();
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            },
                            child: Text("Send email",
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
                  ),
                ],
              )),
        ));
  }
}
