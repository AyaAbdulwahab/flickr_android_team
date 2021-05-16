import 'package:flickr/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:flickr/Widgets/authentication_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../View_Model/networking.dart';
import '../View_Model/networking.dart';

String savedEmail = "shorouk@gmail.com";
String savedPassword = "hello123";

const style = TextStyle(
  fontFamily: 'ProximaNova',
  fontWeight: FontWeight.bold,
);

class EValidator
{
    static String validate(String val){
        return val.isEmpty
            ? "Required"
            :null ;
      }
}



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showWidgets = false;
  String _submitTitle = 'Next';
  String _email;
  String _password;
  bool _hidePassword = true;
  bool _invalidAlert = false;
  bool valueFirst = false;
  final _formKey = GlobalKey<FormState>();

  wrongEmailAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hmm... that\'s not an email address'),
            content: Text(
                'Please enter your complete Flickr account email address (e.g name@domain.com). If you still log in through yahoo, click below to continue.'),
            actions: <Widget>[
              TextButton(
                child: Text('Continue to Yahoo'),
                onPressed: () {},
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Try Again'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          );
        });
  }

  checkEmail() {
    _email = _email.trim();
    bool check = EmailValidator.validate(_email);
    if (check == true) {
      _showWidgets = true;
      _submitTitle = 'Sign in';
    } else {
      wrongEmailAlert(context);
    }
    return check;
  }

  checkAccount() async {
    // if (_email == savedEmail) {
    //   if (_password == savedPassword) {
        _invalidAlert = false;

        Map<String, dynamic> Body = {
          "email":_email,
          "password": _password
        };
        /// Navigate to explore page
        NetworkHelper req= new NetworkHelper(
          "https://c4aca0bd-5ba0-4a26-b6a2-a6b086a3646f.mock.pstmn.io/user/sign-in?ID=1"
        );
        var res = await req.postData(Body);

        if (res.statusCode==200)
          {
            Provider.of<MyModel>(context, listen: false).authUser();
            Navigator.popUntil(context, ModalRoute.withName('/'));
          }
        else
          {
            _invalidAlert = true;
            print(res.statusCode);
          }
      }
    // } else {
    //
    // }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: authAppBar(context),
        body: Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/flickr-logo.png"),
                    height: 17,
                    width: 55,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Log in to Flickr',
                          style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
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
                              "Invalid email or password.",
                            ),
                          ))),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      key: Key("login-email-field"),
                      onChanged: (email) {
                        setState(() {
                          _email = email;
                          _invalidAlert = false;
                        });
                      },
                      onFieldSubmitted: (email) {
                        setState(() {
                          if (_formKey.currentState.validate()) {}
                          if (_email != "" &&
                              _email != null &&
                              _showWidgets == false) {
                            checkEmail();
                            FocusScope.of(context).requestFocus(FocusNode());

                          } else if (_showWidgets == true && _email!="" && _email!=null && _password!=null && _password!="") {
                            checkAccount();
                          }
                        });
                      },
                      validator:EValidator.validate,
                      decoration: InputDecoration(
                          labelText: 'Email address',
                          labelStyle: style,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                            borderSide: BorderSide(color: Colors.pink),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Visibility(
                    visible: _showWidgets,
                    child: Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        key: Key("login-psswrd-field"),
                        enableSuggestions: false,
                        autocorrect: false,
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
                                color: this._hidePassword
                                    ? Colors.grey
                                    : Colors.blue,
                              ),
                              onPressed: () {
                                setState(() =>
                                    this._hidePassword = !this._hidePassword);
                              },
                            ),
                            labelText: 'Password',
                            labelStyle: style,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.0)),
                            )),
                        onChanged: (password) {
                          setState(() {
                            _password = password;
                            _invalidAlert=false;
                          });
                        },
                        onFieldSubmitted: (password){
                          if (_formKey.currentState.validate()) {}
                          setState(() {
                            if ( _email!="" && _email!=null && _password!=null && _password!="") {
                              checkAccount();
                            }
                          });

                        },
                        validator:(val) => val.isEmpty
                            ? "Required"
                            : _email == savedEmail && _password != savedPassword
                            ? "Invalid Password"
                            : null,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _showWidgets,
                    child: Row(children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Checkbox(
                            value: this.valueFirst,
                            onChanged: (bool value) {
                              setState(() {
                                this.valueFirst = value;
                              });
                            }),
                      ),
                      Text('Remember email address', style: style),
                    ]),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    width: double.infinity,
                    height: 40.0,
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                        setState(() {
                          if (_email != "" &&
                              _email != null &&
                              _showWidgets == false) {
                            checkEmail();
                            FocusScope.of(context).requestFocus(FocusNode());
                          } else if (_showWidgets == true && _email!="" && _email!=null && _password!=null && _password!="") {
                            checkAccount();
                          }
                        });
                      },
                      child: Text(
                        _submitTitle,
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                  Visibility(
                      visible: _showWidgets,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                //TODO: Navigate to forgot password page, & pass the email to it.
                              },
                              child: Text('Forgot passowrd?', style: style),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Divider(
                                color: Colors.black,
                              ),
                            )
                          ])),
                  Visibility(
                    visible: !_showWidgets,
                    child: SizedBox(
                      height: 15.0,
                    ),
                  ),

                  SizedBox(
                    width: 200,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 9.0,horizontal: 5.0)),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.blue[600]),
                      ),
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                      ),
                      label: Expanded(
                        child: Text(
                          'Login with facebook',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'ProximaNova',
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Not a Flickr member?', style: style),
                        TextButton(
                            key: Key("signup-here-link"),
                            onPressed: () {
                              /// Navigate to sign up page
                              Navigator.pushNamed(context, '/sign_up');
                            },
                            child: Text(' Sign up here.', style: style)
                          // style :
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ));
  }
}
