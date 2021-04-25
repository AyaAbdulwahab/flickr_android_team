import 'package:email_validator/email_validator.dart';
import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:g_captcha/g_captcha.dart';

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
  bool passwordHint=false;
  String CAPTCHA_SITE_KEY = "6LeePrkaAAAAAF1Tx8KEoVpDqCrHJDfwKPmsX5vX";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
          child: Image(
            image: AssetImage('assets/flickr-logo.png'),
            height: 10.0,
            width: 10.0,
          ),
        ),
        title: Text(
          'flickr',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'Frutiger'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Image(
                  image: AssetImage('assets/flickr-logo.png'),
                  width: 30.0,
                  height: 30.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Sign up for Flickr',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'ProximaNova',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  //initialValue: 'First name',
                  decoration: textInputDecoration.copyWith(
                      hintText: 'First name', hintStyle: addTextStyle),
                  validator: (val) => val.isEmpty ? "Required" : null,
                  onChanged: (val) => _firstName = val,
                ),
                SizedBox(
                  height: 9.0,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Last Name', hintStyle: addTextStyle),
                  onChanged: (val) => _lastName = val,
                  validator: (val) => val.isEmpty ? "Required" : null,
                ),
                SizedBox(
                  height: 9.0,
                ),
                TextFormField(
                  onChanged: (val) => _age = val,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Your age', hintStyle: addTextStyle),
                  validator: (val) => val.isEmpty ? "Required" : ( int.parse(val)<13?"In order to sign up you must be 13 or older":null),
                ),
                SizedBox(
                  height: 9.0,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Required" : EmailValidator.validate(_email)?null:'Invalid email',
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Email address', hintStyle: addTextStyle),
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 9.0,
                ),
                TextFormField(
                  onTap: ()async{
                    setState((){passwordHint=true;});},
                  validator: (val) => val.isEmpty ? "Required" : null,
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Password',
                      hintStyle: addTextStyle,
                      suffixIcon: IconButton(
                          icon: Icon(Icons.remove_red_eye_outlined),
                          onPressed: () => setState(() {
                                _obscureText = !_obscureText;
                              }))),
                  obscureText: _obscureText,
                  onChanged: (val) {},
                ),
                if(passwordHint==true)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  addText('Please use at least:', false),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    addText('12 characters', false),
                    addText('No leading spaces', false),
                  ],)
                ],),
                SizedBox(
                  height: 9.0,
                ),
                CheckboxListTile(
                    value: notRobot,
                    tileColor: Colors.grey[200],
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text("I'm not a robot"),
                    onChanged: (val) => _openReCaptcha),
                
                SizedBox(
                  height: 9.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          
                        }
                      },
                      color: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white),
                      )),
                ),
                SizedBox(height: 9.0),
                addText('By signing up, you agree with', false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Flickr\'s ', style: addTextStyle),
                    InkWell(
                      child: addText('Terms and Services', true),
                      onTap: () {},
                    ),
                    addText(' and ', false)
                  ],
                ),
                InkWell(
                  child: addText('Privacy Policy', true),
                  onTap: () {},
                ),
                Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Already a Flickr member? ',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'ProximaNova', fontWeight: FontWeight.bold,
                        //letterSpacing: 1.0
                      )),
                  InkWell(
                    child: addText('Log in here', true),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }

  _openReCaptcha() async {
    String tokenResult =
        await GCaptcha.reCaptcha("6LeePrkaAAAAAF1Tx8KEoVpDqCrHJDfwKPmsX5vX");
    print('tokenResult: $tokenResult');
    // Fluttertoast.showToast(msg: tokenResult, timeInSecForIosWeb: 4);

    // setState
  }
}



const addTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.grey,
  fontFamily: 'ProximaNova', fontWeight: FontWeight.bold,
  //letterSpacing: 1.0
);
