import 'dart:io';

import 'package:flickr/Views/photo_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatelessWidget {
  PickedFile ip;
  Camera(this.ip);

  Future getImage() async {
    return await ImagePicker().getImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoDetails(ip.path)));
                },
                child: Text("Next")),
            Container(child: Image(image: FileImage(File(ip.path)))),
          ],
        ),
      ),
    );
  }
}
