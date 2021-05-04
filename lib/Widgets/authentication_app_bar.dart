import 'package:flutter/material.dart';

AppBar authAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xFF212124),
    elevation: 0.0,
    toolbarHeight: MediaQuery.of(context).size.height * 0.07,
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
  );
}

//Shorouk
/*
AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Image(
            image: AssetImage("assets/flickr-logo.png"),
            height: 20,
            width: 60,
          ),
          Text('flickr',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30.0,
                fontFamily: 'Frutiger',
              )),
        ]),
      ),
*/
//Aya
/*
AppBar(
        
      ),
*/
