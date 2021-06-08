import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';
import 'package:flickr/Models/user_model.dart';
import 'package:flickr/Widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';

class PhotoTakenDetails extends StatefulWidget {
  String image;
  PhotoTakenDetails(this.image);

  @override
  _PhotoDetailsState createState() => _PhotoDetailsState();
}

class _PhotoDetailsState extends State<PhotoTakenDetails> {
  Future sendPhoto(String img, String token, String title, String desc) async {
    File a = File(img);
    String fileName = a.path.split('/').last;
    print(a);

    FormData formData = new FormData.fromMap({
      "title": title,
      "description": desc,
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

  String _title;
  String _desription;
  bool _isSelected = false;
  List _privacyMembers = [
    "Public",
    "Friends",
    "Family",
    "Friends & Family",
    "Private"
  ];
  int defaultPrivacy = 0;
  List _icons = [
    Icons.location_on_outlined,
    Icons.photo_library_sharp,
    // Icons.tag_outlined,
    Icons.lock_open_outlined
  ];
  @override
  Widget build(BuildContext context) {
    List _titles = [
      "Location",
      "Album",
      "Tags",
      _privacyMembers[defaultPrivacy]
    ];
    List<Function()> func = [
      () {},
      () {},
      () {},
      () {
        setState(() {
          _isSelected = !_isSelected;
          print(_isSelected);
        });
      }
    ];
    return Scaffold(
      body: Stack(children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color(0xFF212124),
            elevation: 0.0,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: OutlinedButton(
                  child: Text("Post",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                  style: OutlinedButton.styleFrom(

                      // padding: EdgeInsets.symmetric(vertical: 0.0),
                      side: BorderSide(color: Colors.white, width: 2.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  onPressed: () async {
                    final user = Provider.of<MyModel>(context, listen: false);
                    await sendPhoto(
                        widget.image, user.getToken(), _title, _desription);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
                top: AppBar().preferredSize.height + 50.0,
                left: 20.0,
                right: 20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  height: 100.0,
                  width: 100.0,

                  // decoration: BoxDecoration(image:FileImage(widget.image)),
                  child: Image(
                      fit: BoxFit.fill, image: FileImage(File(widget.image)))),
              SizedBox(height: 5.0),
              //Add image
              TextField(
                cursorColor: Colors.black,
                textAlignVertical: TextAlignVertical.bottom,
                onChanged: (val) => _title = val,
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.grey[300])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                    color: Colors.black,
                  )),
                  contentPadding: EdgeInsets.all(7),
                  hintText: "Title...",
                ),
              ),
              SizedBox(height: 13.0),
              TextField(
                cursorColor: Colors.black,
                textAlignVertical: TextAlignVertical.bottom,
                onChanged: (val) => _desription = val,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.grey[300])),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    width: 2,
                    color: Colors.black,
                  )),
                  contentPadding: EdgeInsets.all(7),
                  hintText: "Description...",
                ),
              ),
            ])),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.5 - 25.0,
              left: 20.0,
              right: 20.0),
          child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 11.0),
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey[200], thickness: 1),
              itemCount: _titles.length,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    print(index);
                    if (index == 3) {
                      print(index);
                      setState(() {
                        _isSelected = !_isSelected;
                        print(_isSelected);
                      });
                    }
                  },
                  child: UserListTile(
                      _icons[index], _titles[index], 35.0, index))),
        ),
        if (_isSelected)
          GestureDetector(
            onTap: () async {
              setState(() {
                _isSelected = false;
              });
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        if (_isSelected)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5 + 35 * 3 + 9.0,
            left: 32.0,
            child: Container(
              height: 20.0,
              width: 20.0,
              color: Colors.white,
              transform: Matrix4.rotationZ(0.785398),
            ),
          ),
        if (_isSelected)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.125,
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: 340.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 11.0),
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.grey[200], thickness: 1),
                    itemCount: _privacyMembers.length + 1,
                    itemBuilder: (context, index) => index == 0
                        ? Container(
                            height: 50.0,
                            child: Center(
                              child: Text(
                                'Edit Privacy',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ))
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                defaultPrivacy = index - 1;
                                _isSelected = false;
                              });
                            },
                            child: Container(
                                // alignment:
                                height: 50.0,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _privacyMembers[index - 1],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                          )),
              ),
            ),
          ),
      ]),
    );
  }
}
