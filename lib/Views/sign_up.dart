import 'package:email_validator/email_validator.dart';
import 'package:flickr/Widgets/authentication_app_bar.dart';
import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_recaptcha_v2/flutter_recaptcha_v2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:g_captcha/g_captcha.dart';
// import '../ViewModels/cap.java';

class NameValidation {
  static String validate(String val) {
    return val.isEmpty ? "Required" : null;
  }
}

class AgeValidation {
  static String validate(String val) {
    return val.isEmpty
        ? "Required"
        : double.tryParse(val) == null
            ? "Please enter a valid no"
            : double.tryParse(val).truncateToDouble() < 13
                ? "In order to sign up you must be 13 or older"
                : null;
  }
}

class EmailValidation {
  static String validate(String val) {
    return val.isEmpty
        ? "Required"
        : EmailValidator.validate(val.trim())
            ? null
            : 'Invalid email';
  }
}

class PasswordValidation {
  static String validate(String val) {
    return val.isEmpty
        ? "Required"
        : val[0] == " " || val.length < 12
            ? "Invalid Password"
            : null;
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String _age = "";
  String _email = "";
  String _firstName = "";
  String _lastName = "";
  String _password = "";
  bool checkNoOfChars = false;
  bool checkSpace = false;
  bool notRobot = false;
  bool _obscureText = true;
  bool passwordHint = false;
  String verifyResult = "";

  // String captchaSiteKey = "6LeePrkaAAAAAF1Tx8KEoVpDqCrHJDfwKPmsX5vX";
  // RecaptchaV2Controller recaptchaV2Controller = RecaptchaV2Controller();

  final f3 = FocusNode();
  final f4 = FocusNode();

  @override
  void initState() {
    super.initState();
    // recaptchaV2Controller.show();
    f3.addListener(() {
      print("Has focus: ${f3.hasFocus}");
      if (!f3.hasFocus) setState(() {});
    });
    f4.addListener(() {
      print("Has focus: ${f4.hasFocus}");
      if (!f4.hasFocus)
        setState(() {
          passwordHint = false;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: FocusScope(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      Image(
                        image: AssetImage('assets/flickr-logo.png'),
                        width: 30.0,
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        'Sign up for Flickr',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        key: Key('firstName'),
                        decoration: textInputDecoration.copyWith(
                            labelText: 'First name', labelStyle: addTextStyle),
                        validator: NameValidation.validate,
                        onChanged: (val) => _firstName = val,
                      ),
                      SizedBox(
                        height: 9.0,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Last Name', labelStyle: addTextStyle),
                        onChanged: (val) => _lastName = val,
                        validator: NameValidation.validate,
                      ),
                      SizedBox(
                        height: 9.0,
                      ),
                      TextFormField(
                        focusNode: f3,
                        onChanged: (val) => _age = val,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Your age', labelStyle: addTextStyle),
                        validator: AgeValidation.validate,
                      ),
                      SizedBox(
                        height: 9.0,
                      ),
                      TextFormField(
                        validator: EmailValidation.validate,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Email address',
                            labelStyle: addTextStyle),
                        onChanged: (val) {},
                      ),
                      SizedBox(
                        height: 9.0,
                      ),
                      TextFormField(
                        onTap: () async {
                          setState(() {
                            passwordHint = true;
                          });
                        },
                        focusNode: f4,
                        validator: PasswordValidation.validate,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Password',
                            labelStyle: addTextStyle,
                            suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye_outlined),
                                onPressed: () => setState(() {
                                      _obscureText = !_obscureText;
                                    }))),
                        obscureText: _obscureText,
                        onChanged: (val) {
                          _password = val;
                          if (val.length >= 1) {
                            if (val.startsWith(" ")) {
                              setState(() {
                                checkSpace = false;
                              });
                            } else {
                              if (!checkSpace)
                                setState(() {
                                  checkSpace = true;
                                });
                            }
                          } else {
                            setState(() {
                              checkSpace = false;
                            });
                          }

                          if (val.length < 12) {
                            if (checkNoOfChars) {
                              setState(() {
                                checkNoOfChars = false;
                              });
                            }
                          } else {
                            if (!checkNoOfChars) {
                              setState(() {
                                checkNoOfChars = true;
                              });
                            }
                          }
                        },
                      ),
                      if (passwordHint == true)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              'Please use at least:',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    checkNoOfChars
                                        ? Icon(Icons.check_circle,
                                            color: Colors.blue)
                                        : Icon(
                                            Icons.lens_outlined,
                                            color: Colors.grey,
                                          ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      '12 characters',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    checkSpace
                                        ? Icon(Icons.check_circle,
                                            color: Colors.blue)
                                        : Icon(
                                            Icons.lens_outlined,
                                            color: Colors.grey,
                                          ),
                                    SizedBox(width: 5.0),
                                    Text(
                                      'No leading spaces',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      SizedBox(
                        height: 9.0,
                      ),
                      // RaisedButton(
                      //   onPressed: () => _openReCaptcha(),
                      //   child: Text("I'm not a robot"),
                      // ),
                      SizedBox(
                        height: 9.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                            elevation: 0.0,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {}
                            },
                            color: Colors.blue[600],
                            padding: EdgeInsets.symmetric(vertical: 9.0),
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                  fontFamily: 'ProximaNova',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              child: Divider(
                            thickness: 2,
                          )),
                          Text('or'),
                          Expanded(
                              child: Divider(
                            thickness: 2,
                          ))
                        ],
                      ),
                      RaisedButton.icon(
                        onPressed: () {},
                        color: Colors.blue[600],
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          // color: Colors.blue[900],
                        ),
                        label: Expanded(
                          child: Text(
                            'Continue with facebook',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'ProximaNova',
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 9.0),
                      addText('By signing up, you agree with', false),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addText('Flickr\'s ', false),
                          InkWell(
                            child: addText('Terms of Services', true),
                            onTap: () {},
                          ),
                          addText(' and', false)
                        ],
                      ),
                      InkWell(
                        child: addText('Privacy Policy', true),
                        onTap: () {},
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already a Flickr member? ',
                                style: TextStyle(
                                  fontSize: 13.0,
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: addText('Log in here', true),
                            ),
                          ])
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// _openReCaptcha() async {
//   String tokenResult =
//       await GCaptcha.reCaptcha("6LfJDMMaAAAAAHHYPOlHzw7oBjHTNj3m2Xt9qrhR");
//   print('tokenResult: $tokenResult');
// }

const addTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.grey,
);
