import 'dart:io';

import 'package:flickr/Views/photo_taken_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// The [Camera] widget is opened on clicking on the camera icon in the
/// navigation bar to let the user take a photo then gives the user an option
/// to proceed to te next page, where he should choose the title and description
/// for this photo.

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
                          builder: (context) => PhotoTakenDetails(ip.path)));
                },
                child: Text("Next")),
            Container(child: Image(image: FileImage(File(ip.path)))),
          ],
        ),
      ),
    );
  }
}
