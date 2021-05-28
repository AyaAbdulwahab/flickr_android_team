

import 'package:flutter/material.dart';
import 'package:flickr/Constants/constants.dart';

void main() {
  return runApp(
      MaterialApp(
          home: Privacy()
      )
  );
}

int _selectedRadio=1; //TODO: change according to setting of each user


class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}



class _PrivacyState extends State<Privacy> {

  final List<Function> tilesAction = [() {}, () {}, () {}, () {}, () {}];
  bool _exif=false; // TODO: Change according to data of the user



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
                'Privacy and Safety',
                style: TextStyle(fontSize: 17.0),
              )),
          leadingWidth: 300.0,
          elevation: 0.0,
          backgroundColor: Colors.black87,
          actions: [
            IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        body: ListView(
            padding: EdgeInsets.only(top: 11.0),
            children: <Widget> [
              BuildTile(
                  title: PrivacySettingsView.tilesTitles[0],
                  body: PrivacySettingsView.tilesBody[0],
                  settingIndex: 0,
                  titlesList: PrivacySettingsView.defaultPrivacy
              ),
              BuildTile(
                  title: PrivacySettingsView.tilesTitles[1],
                  body: PrivacySettingsView.tilesBody[1],settingIndex: 1,
                  titlesList: PrivacySettingsView.locationPrivacy),
              BuildTile(title: PrivacySettingsView.tilesTitles[2],
                  body: PrivacySettingsView.tilesBody[2],
                  settingIndex: 2,
                  titlesList: PrivacySettingsView.safetyLevel),
              SwitchListTile(
                  title: Text(PrivacySettingsView.tilesTitles[3],
                    style: TextStyle( fontWeight: FontWeight.w600,
                        fontFamily: 'ProximaNova'
                    ),
                  ),
                  subtitle: Text(
                    PrivacySettingsView.tilesBody[3],
                    style: TextStyle( fontWeight: FontWeight.w600,
                        fontFamily: 'ProximaNova'),
                  ) ,
                  value: _exif,
                  onChanged: (bool value) {
                    setState(() {
                      //TODO: Request here
                      _exif = value;
                    });
                  }
              ),
              const Divider(thickness:1),
              BuildTile(
                  title: PrivacySettingsView.tilesTitles[4],
                  body: PrivacySettingsView.tilesBody[4],
                  settingIndex: 3,
                  titlesList: PrivacySettingsView.safeSearchFilter
              ),

            ]


        ));
  }
}


class BuildTile extends StatefulWidget {
  BuildTile({
    Key key,
    @required this.title,
    @required this.body,
    @required this.settingIndex,
    @required this.titlesList
  }) : super(key: key);
  final String title;
  final String body;
  final int settingIndex;
  final List <String> titlesList;
  @override
  _BuildTileState createState() => _BuildTileState();
}

class _BuildTileState extends State<BuildTile> {


  createPrivacyDialog(BuildContext context, String title, int number){
    return showDialog(context: context, builder: (BuildContext context) {
      return Dialog(
          title: title,
          settingIndex: number,
          titlesList: widget.titlesList
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget> [
        GestureDetector(
          child: ListTile(
            title: Text(widget.title, style: TextStyle( fontWeight: FontWeight.w600, fontFamily: 'ProximaNova')),
            subtitle: Text(widget.body, style: TextStyle( fontWeight: FontWeight.w600, fontFamily: 'ProximaNova')),
            onTap: (){
              createPrivacyDialog(context,widget.title, widget.settingIndex);
            },
          ),
        ),
        const Divider(thickness:1),
      ],
    );
  }
}

class Dialog extends StatefulWidget {
  Dialog({
    Key key,
    @required this.title,
    @required this.settingIndex,
    @required this.titlesList

  }) : super(key: key);

  final List <String> titlesList;
  final String title;
  final int settingIndex;

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Container(
        height: 290.0,
        width: 250.0,
        child: ListView.builder(
          // padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          itemCount: widget.titlesList.length,
          itemExtent: 50.0,
          itemBuilder: (BuildContext context, int index) {
            return RadioListTile(
              title: Text(widget.titlesList[index]),
              value: index,
              groupValue:_selectedRadio,
              activeColor: Colors.green.shade700,
              onChanged: (newValue) {
                setState(() {
                  print("Radio Tile pressed $newValue");
                  _selectedRadio = newValue;
                  // print("Radio Tile pressed $_selectedRadio");
                  //TODO: Request here
                  Navigator.pop(context);

                });
              },
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel', style: TextStyle(fontSize: 20.0)),
          style: TextButton.styleFrom(
            primary: Colors.green.shade700,
          ),
        ),

      ],
    );
  }
}



