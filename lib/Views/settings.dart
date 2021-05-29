import 'package:flickr/View_Model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

/// This Widget shows the bottom sheet giving some actions the user can perform
/// such as:
/// * Join Pro                  * Privacy and Safety
/// * Notifications             * Use Native Video Camera
/// * Feedback                  * About
/// * Help                      * Sign Out

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _notifications = true;

  bool _useNativeVideoCam = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text(
            'Join Pro',
            style: TextStyle(color: Colors.blue[900]),
          ),
          leading: Icon(
            FontAwesomeIcons.crown,
            color: Colors.blue[900],
          ),
        ),
        ListTile(
          title: Text('Notifications'),
          onTap: () => setState(() => _notifications = !_notifications),
          trailing: Switch(
              value: _notifications,
              onChanged: (val) =>
                  setState(() => _notifications = !_notifications)),
        ),
        ListTile(
          title: Text('Privacy and Safety'),
          onTap: () {},
        ),
        ListTile(
            title: Text('Use Native Video Camera'),
            onTap: () =>
                setState(() => _useNativeVideoCam = !_useNativeVideoCam),
            trailing: Switch(
                value: _useNativeVideoCam,
                onChanged: (val) =>
                    setState(() => _useNativeVideoCam = !_useNativeVideoCam))),
        Divider(
          indent: 15.0,
        ),
        ListTile(
          title: Text('Feedback'),
          onTap: () {},
        ),
        ListTile(
          key: Key("About-menu-btn"),
          title: Text('About'),
          onTap: () {
            Navigator.pushNamed(context, '/About_Menu');
          },
        ),
        ListTile(
          title: Text('Help'),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          key: Key("Sign-out-btn"),
          onTap: () {
            final user = Provider.of<MyModel>(context, listen: false);
            user.setToken(null);
            user.setID(null);
            user.unAuthUser();
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          title: Text(
            'Sign Out',
            style: TextStyle(color: Colors.grey),
          ),
          tileColor: Colors.black,
        ),
      ],
    );
  }
}
