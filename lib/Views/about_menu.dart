import 'package:flutter/material.dart';

/// This Menu contains the following options for the user
/// * Community Guidelines
/// * Terms and Services
/// * Privacy Policy
/// * Credits
/// * Cover Photo
/// * Build Version
/// * Build ID
class AboutMenu extends StatelessWidget {
  final List<String> tiles = [
    'Community Guidelines',
    'Terms of Service',
    'Privacy Policy',
    'Credits',
    'Cover Photo'
  ];
  final List<Function> tilesAction = [() {}, () {}, () {}, () {}, () {}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Center(
              child: Text(
            'About',
            style: TextStyle(fontSize: 17.0),
          )),
          leadingWidth: 100.0,
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
        body: ListView.separated(
            padding: EdgeInsets.only(top: 11.0),
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[300],
                  thickness: 1.1,
                ),
            itemCount: tiles.length,
            itemBuilder: (context, index) => ListTile(
                  onTap: () => index != 3
                      ? tilesAction[index]
                      : Navigator.pushNamed(context, '/credits'),
                  minVerticalPadding: 10.0,
                  title: Text(
                    tiles[index],
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontFamily: 'ProximaNova'),
                  ),
                )));
  }
}
