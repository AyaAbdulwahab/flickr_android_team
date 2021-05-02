import 'package:email_validator/email_validator.dart';
import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recaptcha_v2/flutter_recaptcha_v2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:g_captcha/g_captcha.dart';
// import '../ViewModels/cap.java';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool notRobot = false;
  final _formKey = GlobalKey<FormState>();
  String _firstName = "";
  String _lastName = "";
  String _age = "";
  String _email = "";
  String _password = "";
  bool _obscureText = true;
  bool passwordHint = false;
  bool checkSpace = false;
  bool checkNoOfChars = false;
  String captchaSiteKey = "6LeePrkaAAAAAF1Tx8KEoVpDqCrHJDfwKPmsX5vX";
  String verifyResult = "";

  RecaptchaV2Controller recaptchaV2Controller = RecaptchaV2Controller();

  FocusNode f1;
  FocusNode f2;
  final f3 = FocusNode();
  final f4 = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
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
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        backgroundColor: Colors.black.withOpacity(0.81),
        leadingWidth: MediaQuery.of(context).size.width * 0.5,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
          children: [
            Image(
              image: AssetImage('assets/flickr-logo.png'),
              //height: MediaQuery.of(context).size.height * 0.07,
              width: 25.0,
              height: 25.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              'flickr',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Frutiger'),
            ),
          ],
        ),
      ),
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
                        decoration: textInputDecoration.copyWith(
                            labelText: 'First name', labelStyle: addTextStyle),
                        validator: (val) => val.isEmpty ? "Required" : null,
                        onChanged: (val) => _firstName = val,
                      ),
                      SizedBox(
                        height: 9.0,
                      ),
                      TextFormField(
                        // focusNode: f2,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Last Name', labelStyle: addTextStyle),
                        onChanged: (val) => _lastName = val,
                        validator: (val) => val.isEmpty ? "Required" : null,
                      ),
                      SizedBox(
                        height: 9.0,
                      ),
                      TextFormField(
                        focusNode: f3,
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (val) => _age = val,
                        decoration: textInputDecoration.copyWith(
                            labelText: 'Your age', labelStyle: addTextStyle),
                        validator: (val) => val.isEmpty
                            ? "Required"
                            : double.tryParse(val) == null
                                ? "Please enter a valid no"
                                : double.tryParse(val).truncateToDouble() < 13
                                    ? "In order to sign up you must be 13 or older"
                                    : null,
                      ),
                      SizedBox(
                        height: 9.0,
                      ),
                      TextFormField(
                        validator: (val) => val.isEmpty
                            ? "Required"
                            : EmailValidator.validate(_email)
                                ? null
                                : 'Invalid email',
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
                        validator: (val) => val.isEmpty ? "Required" : null,
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
                      //     onPressed: () => recaptchaV2Controller.show(),
                      //     child: Text('reCaptcha')),
                      RaisedButton(
                        onPressed: () => _openReCaptcha(),
                        child: Text("I'm not a robot"),
                      ),
                      // CheckboxListTile(

                      //     value: notRobot,
                      //     tileColor: Colors.grey[200],
                      //     controlAffinity: ListTileControlAffinity.leading,
                      //     title: Text("I'm not a robot"),
                      //     onChanged: (val) => _openReCaptcha),
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
                              onTap: (){
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

_openReCaptcha() async {
  String tokenResult =
      await GCaptcha.reCaptcha("6LfJDMMaAAAAAHHYPOlHzw7oBjHTNj3m2Xt9qrhR");
  print('tokenResult: $tokenResult');
}

const addTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.grey,
);
