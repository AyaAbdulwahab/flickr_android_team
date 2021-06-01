import 'package:flickr/View_Model/user_view_model.dart';
import 'package:flickr/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:flickr/Widgets/authentication_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';

const style = TextStyle(
  fontFamily: 'ProximaNova',
  fontWeight: FontWeight.bold,
);

/// Validator class for email TextFormField
class EValidator {
  static String validate(String val) {
    return val.isEmpty ? "Required" : null;
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /// The visibility for the input password field
  bool _showWidgets = false;

  /// The text for the confirm button
  String _submitTitle = 'Next';

  /// The text for the invalid credentials alert
  String _invalidText = "Invalid";

  /// The entered text for the email field
  String _email;

  /// The entered text for the password field
  String _password;

  /// The visibility for the entered password text
  bool _hidePassword = true;

  /// The visibility for the invalid credentials alert
  bool _invalidAlert = false;

  /// The value for the "Remember email address" checkbox
  bool valueFirst = false;

  final _formKey = GlobalKey<FormState>();

  /// Shows an AlertDialog if [_email] is not in the correct format
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

  /// Checks if the entered text is in correct email format
  ///
  /// Changes the values of [_showWidgets] and [_submitTitle] if [_email] is in correct email format,
  /// Calls the alert function [wrongEmailAlert] if not.
  checkEmail() {
    _email = _email.trim();
    bool check = EmailValidator.validate(_email);
    if (check == true) {
      _showWidgets = true;
      _submitTitle = 'Sign in';
    } else {
      wrongEmailAlert(context);
    }
    // return check;
  }

  /// Sends a post request containing [_email] and [_password] to the url
  ///
  /// Sends the request in the try block, and catches hthe error and prints it. It parses the response body as JSON
  ///Checks for the response code and the message in the JSON
  /// Navigates to the next view with the [token] in the route if response status code is 200
  /// Changes [_invalidAlert] to true if otherwise to display alert message
  logIn(String email, String password) async {
    try {
      final response = await Dio().post(EndPoints.baseUrl + '/user/sign-in',
          options: Options(
              validateStatus: (_) {
                return true;
              },
              responseType: ResponseType.json),
          data: jsonEncode({
            "email": email,
            "password": password,
          }));
      print(response);
      var responseBody = response.data;
      if (responseBody['token'] != null && response.statusCode == 200) {
        final user = Provider.of<MyModel>(context, listen: false);
        user.authUser();
        user.setToken(responseBody['token']);
        user.setID(responseBody["data"]["user"]["_id"]);
        List a = await getFollowers(user.getID(), user.getToken());

        user.setFollowers(a);
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
        Navigator.popUntil(context, ModalRoute.withName('/'));
      } else if (responseBody['message'] != null) {
        // No account exists with this email
        if (responseBody['message'] == "Invalid Email") {
          setState(() {
            _invalidText = "Invalid email or password.";
            _invalidAlert = true;
          });

          return true;
        } else if (responseBody['message'] == "Invalid Password") {
          setState(() {
            _invalidText = "Invalid password";
            _invalidAlert = true;
          });
          return false;
        }
      }
    } catch (error) {
      print(error);
    }
  }

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
                    /// A widget for invalid [_email] or [_password] alert
                    visible: _invalidAlert,
                    child: Container(
                      width: 370.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          border: Border.all(
                            color: Colors.red[100],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Center(
                        child: Text(
                          _invalidText,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  /// A widget for email input, toggles [_invalidAlert] to false if [_email] changes
                  /// Validates [_email] with [checkEmail] and [EValidator]
                  /// Sends a request when credentials exist using [logIn(String email, String password)]
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
                          }
                        });
                        if (_showWidgets == true &&
                            _email != "" &&
                            _email != null &&
                            _password != null &&
                            _password != "") {
                          logIn(_email, _password);
                        }
                      },
                      validator: EValidator.validate,
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
                    /// A widget for [_password] input, toggles [_invalidAlert] to false if [_password] changes
                    /// Sends a request when credentials exist using [logIn(String email, String password)]
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
                              _invalidAlert = false;
                            });
                          },
                          onFieldSubmitted: (password) {
                            if (_formKey.currentState.validate()) {}

                            if (_email != "" &&
                                _email != null &&
                                _password != null &&
                                _password != "") {
                              logIn(_email, _password);
                            }
                          },
                          validator: (val) => val.isEmpty ? "Required" : null
                          // : _email == savedEmail && _password != savedPassword
                          // ? "Invalid Password"
                          // : null,
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
                    /// TextButton widget for sending POST request with [_email] and [_password] using [logIn(String email, String password)]
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    width: double.infinity,
                    height: 40.0,
                    child: TextButton(
                      key: Key("log-in-nxt-btn"),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {}
                        setState(() {
                          if (_email != "" &&
                              _email != null &&
                              _showWidgets == false) {
                            checkEmail();
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            currentFocus.requestFocus(FocusNode());

                            // if (!currentFocus.hasPrimaryFocus) {
                            //   currentFocus.unfocus();
                            // }
                          }
                        });
                        if (_showWidgets == true &&
                            _email != "" &&
                            _email != null &&
                            _password != null &&
                            _password != "") {
                          logIn(_email, _password);
                        }
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: 9.0, horizontal: 5.0)),
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

                      ///A widget to navigate to the signUp page
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
