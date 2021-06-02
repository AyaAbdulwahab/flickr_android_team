import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  IconData _icon;
  String _title;
  double _height;
  int index;
  UserListTile(this._icon, this._title, this._height, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _height,
        child: Row(
          children: [
            Icon(
              _icon,
              color: index == 3 ? Colors.black : Colors.grey[600],
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              _title,
              style: TextStyle(
                  color: index == 3 ? Colors.black : Colors.grey[600],
                  fontSize: 16.0),
            )
          ],
        ));
  }
}
