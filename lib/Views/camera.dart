import 'dart:io';

import 'package:flickr/Views/loading.dart';
import 'package:flickr/Views/photo_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatelessWidget {
  PickedFile ip;
  Camera(this.ip);

  Future getImage() async {
    PickedFile ip;
    return await ImagePicker().getImage(source: ImageSource.camera);
    // setState(() {
    //   _image=File(image.path);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: getImage(),
    //     builder: (context, snapshot) {
    // if (snapshot.hasData) {
    //   print(snapshot.data);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoDetails(File(ip.path))));
                },
                child: Text("Next")),
            // Container(child: Image(image: FileImage(File(ip.path)))),
          ],
        ),
      ),
    );
    // } else
    //   return LoadingPage();
    // }
    // )
    // ;
  }
}
