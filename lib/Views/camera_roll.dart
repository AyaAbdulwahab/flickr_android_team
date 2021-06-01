import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';
import 'package:flickr/View_Model/user_func_view_model.dart';
import 'package:flickr/View_Model/user_view_model.dart';
import 'package:flickr/Views/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';

class CameraRoll extends StatefulWidget {
  @override
  _CameraRollState createState() => _CameraRollState();
}

class _CameraRollState extends State<CameraRoll> {
  Future<File> getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    return File(image.path);
  }

  Future sendPhoto(String token) async {
    File a = await getImage();
    String fileName = a.path.split('/').last;
    print(a);

    FormData formData = new FormData.fromMap({
      "title": "title",
      "description": "desc",
      "photo": await MultipartFile.fromFile(a.path,
          filename: fileName, contentType: MediaType('image', 'jpg')),
    });
    print("FORMDATAAA: " + fileName);
    try {
      Dio dio = new Dio();
      dio.options.headers = {"authorization": "Bearer " + token};
      var response =
          await dio.post(EndPoints.baseUrl + "/photo/", data: formData);
      print(response);
    } catch (e) {
      print(e);
    }
  }

  List sortBy = ["Date Taken", "Date Uploaded"];

  int defaultIndex = 1;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyModel>(context, listen: false);

    return FutureBuilder(
        future: getCameraRoll(user.getToken()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List photos = snapshot.data ?? [];
            return Column(
              children: [
                Container(
                  color: Colors.grey[200],
                  child: photos.length == 0
                      ? Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 40.0),
                            Icon(
                              Icons.photo_outlined,
                              size: 50.0,
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              "Upload you photos!",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[600]),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Got a lot of photos? We've",
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.grey[600]),
                            ),
                            // SizedBox(height: 5.0),
                            Text(
                              "got a lot of space.",
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.grey[600]),
                            ),
                            SizedBox(height: 7.0),
                            OutlinedButton(
                              child: Text("Upload now",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Colors.black, width: 2.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero)),
                              onPressed: () async {
                                await sendPhoto(user.getToken());
                              },
                            )
                          ],
                        )
                      : GestureDetector(
                          onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        setState(() {
                                          defaultIndex = 0;
                                        });
                                        Navigator.pop(context);
                                      },
                                      title: Text(sortBy[0]),
                                    ),
                                    Divider(),
                                    ListTile(
                                      onTap: () {
                                        setState(() {
                                          defaultIndex = 1;
                                        });
                                        Navigator.pop(context);
                                      },
                                      title: Text(sortBy[1]),
                                    ),
                                  ],
                                );
                              }),
                          child: Container(
                            height: 45.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(sortBy[defaultIndex]),
                                Icon(Icons.arrow_drop_down_sharp)
                              ],
                            ),
                          ),
                        ),
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 110 / 140,
                      children: List.generate(photos.length, (index) {
                        return Image.network(
                            photos[index]["sizes"]["size"]["medium"]["url"]);
                      })),
                ),
              ],
            );
          } else
            return LoadingPage();
        });
  }
}
