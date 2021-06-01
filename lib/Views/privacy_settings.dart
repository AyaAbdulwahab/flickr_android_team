import 'package:flutter/material.dart';
import 'package:flickr/View_Model/user_view_model.dart';
import 'package:flickr/Constants/constants.dart';
import '../Models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';



/// The [Privacy] is were user can change their account Privacy and Safety setting
///
/// The settings include
/// * Default Privacy
/// * Location Privacy
/// * Safety Level
/// * Import EXIF location data
/// * SafeSearch filter

void main() {
  return runApp(
      MaterialApp(
          home: Privacy()
      )
  );
}






/// An object of type [PrivacyInfo] where data is parsed and stored from page requests
PrivacyInfo info;
/// The invoking variable for builder of [FutureBuilder] widget
Future<int> variableBuilder;



/// Updates fields in [info] when a new value is selected
///
/// Checks which privacy the user changed using the [AlertDialog] title, and changes the corresponding field in [info] accordingly
updateInfo(String title, value)
{
  if (title==PrivacySettingsView.tilesTitles[0])
  {
    info.def=value+1;
  }
  else if (title==PrivacySettingsView.tilesTitles[1])
  {
    info.location=value+1;
  }
  else if (title==PrivacySettingsView.tilesTitles[2])
  {
    info.safetyLevel=value+1;
  }
  else if (title==PrivacySettingsView.tilesTitles[3])
  {
    info.importEXIF=value;
  }
  else if (title==PrivacySettingsView.tilesTitles[4])
  {
    info.safeSearch=value+1;
  }
}


class Privacy extends StatefulWidget {
  @override
  _PrivacyState createState() => _PrivacyState();
}



class _PrivacyState extends State<Privacy> {

  final List<Function> tilesAction = [() {}, () {}, () {}, () {}, () {}];


  @override
  void initState() {
    super.initState();
    variableBuilder=getData();
  }


  Future<int> getData() async{
    info=await getPrivacy();
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<MyModel>(context, listen: false);
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
        body: FutureBuilder(
            future: variableBuilder,
            builder: (context,snapshot) {
              if (snapshot.data == null) { //<-- Add this condition
                // return LoadingPage(); //TODO: Check if you will change it
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:<Widget>[
                          Image(
                            image: AssetImage("assets/flickr-logo.png"),
                            height: 20,
                            width: 58,
                          ),

                        ]
                    ),
                  ],
                );
              }
              else {
                return  ListView(
                    padding: EdgeInsets.only(top: 11.0),
                    children: <Widget> [
                      BuildTile(
                        title: PrivacySettingsView.tilesTitles[0],
                        body: PrivacySettingsView.tilesBody[0],
                        value:info.def,
                        titlesList: PrivacySettingsView.defaultPrivacy,
                        // info: info
                      ),
                      BuildTile(
                        title: PrivacySettingsView.tilesTitles[1],
                        body: PrivacySettingsView.tilesBody[1],
                        value: info.location,
                        titlesList: PrivacySettingsView.defaultPrivacy,
                        // info: info
                      ),
                      BuildTile(title: PrivacySettingsView.tilesTitles[2],
                        body: PrivacySettingsView.tilesBody[2],
                        value: info.safetyLevel,
                        titlesList: PrivacySettingsView.safetyLevel,
                        // info: info
                      ),
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
                          value: info.importEXIF,
                          onChanged: (bool value) async{
                            setState(() {
                              info.importEXIF = value;
                            });
                            info=await updatePrivacy(info);
                            setState(() {
                              info.importEXIF = info.importEXIF; // Stupid I know
                            });
                          }
                      ),
                      const Divider(thickness:1),
                      BuildTile(
                        title: PrivacySettingsView.tilesTitles[4],
                        body: PrivacySettingsView.tilesBody[4],
                        value: info.safeSearch,
                        titlesList: PrivacySettingsView.safeSearchFilter,
                        // info: _info
                      ),

                    ]
                );
              }
            }
        ));
  }
}


class BuildTile extends StatefulWidget {
  BuildTile({
    Key key,
    @required this.title,
    @required this.body,
    @required this.value,
    @required this.titlesList,
  }) : super(key: key);
  final String title;
  final String body;
  final int value;
  final List <String> titlesList;
  @override
  _BuildTileState createState() => _BuildTileState();
}

class _BuildTileState extends State<BuildTile> {

  createPrivacyDialog(BuildContext context, String title, int number){
    return showDialog(context: context, builder: (BuildContext context) {
      return Dialog(
        title: title,
        // value: number,
        titlesList: widget.titlesList,
        // info: info
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
              createPrivacyDialog(context,widget.title, widget.value);
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
    @required this.titlesList,
  }) : super(key: key);

  final List <String> titlesList;
  final String title;



  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> {

  int _value;
  @override
  void initState() {
    super.initState();
    _value= widget.title==PrivacySettingsView.tilesTitles[0]
        ? info.def:
    widget.title==PrivacySettingsView.tilesTitles[1]
        ? info.location :
    widget.title==PrivacySettingsView.tilesTitles[2]
        ? info.safetyLevel :
    widget.title==PrivacySettingsView.tilesTitles[4]
        ? info.safeSearch :
    -1;
  }

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
              value:index,
              groupValue: _value-1,
              activeColor: Colors.green.shade700,
              onChanged: (newValue) async{
                updateInfo(widget.title,newValue);
                info = await updatePrivacy(info);
                Navigator.pop(context);
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



