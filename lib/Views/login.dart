import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'sign_up.dart';
 const style =TextStyle(
    fontFamily: 'ProximaNova', fontWeight: FontWeight.bold,
 );

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor:Color(0xFF212124) ,
          title: Row (
            mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(
              image: AssetImage("assets/flickr-logo.png"),
              height: 20,
              width: 60,
            ),
          Text(
              'flickr',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
              fontFamily: 'Frutiger',
            )
          ),
        ]
          ),
        ),
         body: Login(),
      ),
    ),
  );
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
    bool _showWidgets=false;
    String _submitTitle='Next';
    String _email;
    bool _hidePassword=true;
    bool valueFirst = false;
    // bool valueSecond = false;
    wrongEmailAlert(BuildContext context)
  {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Hmm... that\'s not an email address'),
              content: Text('Please enter your complete Flickr account email address (e.g name@domain.com). If you still log in through yahoo, click below to continue.'),
              actions: <Widget>[
              TextButton(
                child: Text('Continue to Yahoo'),
              ),
              TextButton(
                onPressed: (){
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
          }
      );
  }
   checkEmail(_email)
  {
    bool check=EmailValidator.validate(_email);
    if (check==true)
      {
        _showWidgets=true;
        _submitTitle='Sign in';
      }
    else
      {
        wrongEmailAlert(context);
      }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:25.0),
      child: SingleChildScrollView(
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
            Text(
            'Log in to Flickr',
              style:TextStyle(
                fontFamily: 'ProximaNova',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              )
            ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left:20.0,right:20.0 ),
              child: TextField(
                onChanged: (email){
                  print('ana hena');
                  _email=email;
                   },
                 onSubmitted: (email){
                  setState(() {
                    checkEmail(_email);
                  });
                },
                decoration: InputDecoration(
                  labelText:'Email address',
                  labelStyle: style,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                    borderSide: BorderSide(color:Colors.pink),
                  )
                ),
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            Visibility (
              visible: _showWidgets,
              child:Container(
                padding: EdgeInsets.only(left:20.0,right:20.0 ),
                child: TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: this._hidePassword ? Colors.grey : Colors.blue,
                        ),
                        onPressed: () {
                          setState(() => this._hidePassword = !this._hidePassword);
                        },
                      ),
                      labelText:'Password',
                      labelStyle: style,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),)
                      )
                  ),
                ),
              ),
            Visibility(
              visible: _showWidgets,
              child: Row(
                children:<Widget> [
                  Container(
                    padding: EdgeInsets.only(left:5.0),
                    child: Checkbox(
                    value: this.valueFirst,
                    onChanged: (bool value) {
                      setState(() {
                        this.valueFirst = value;
                      });
                    }
                ),
                  ),
                  Text('Remember email address', style:style),
                ]
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.only(left:20.0,right:20.0),
              width: double.infinity ,
              height: 40.0,
             child: TextButton(
              onPressed: (){
                setState(() {
                    checkEmail(_email);
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
                children: <Widget> [
                  TextButton(
                    onPressed:(){
                      //TODO: Navigate to forgot password page, & pass the email to it.
                    },
                    child: Text('Forgot passowrd?',style:style),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:20.0,right:20.0),
                    child: Divider(
                        color: Colors.black,

                    ),
                  )
                ]
              )
            ),
            Visibility(
              visible: !_showWidgets,
              child: SizedBox(
                height: 15.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Text('Not a Flickr member?', style: style),
                TextButton(
                    onPressed: (){
                      //TODO: Navigate to sign up page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)  {
                        return SignUp();
                        },
                      ),
                      );
                    },
                    child: Text(' Sign up here.', style:style)
                  // style :
                )
              ]
            )
        ],
        ),
      ),
    );
  }
}
//