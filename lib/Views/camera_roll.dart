import 'package:flickr/Models/user_model.dart';
import 'package:flickr/View_Model/photo_view_model.dart';
import 'package:flickr/View_Model/user_func_view_model.dart';
import 'package:flickr/Views/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// In the [CameraRoll] Page, while their is no data available the [LoadingPage]
/// appear, then it checks if the user has any uploaded photos to decide which
/// interface to show

class CameraRoll extends StatefulWidget {
  @override
  _CameraRollState createState() => _CameraRollState();
}

class _CameraRollState extends State<CameraRoll> {
  List sortBy = ["Date Taken", "Date Uploaded"];

  int defaultIndex = 1;
  int noOfSelectedPhotos = 0;
  List<bool> isSelected = [];
  bool select = true;
  List photos = [];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyModel>(context, listen: false);

    return FutureBuilder(
        future: getCameraRoll(user.getToken()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            photos = snapshot.data ?? [];
            if (photos.length > isSelected.length) {
              for (int i = isSelected.length; i < photos.length; i++) {
                isSelected.add(false);
              }
            }
            return Center(
              child: Column(children: [
                photos.length == 0
                    ? Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey[200],
                          child: Column(
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
                          ),
                        ),
                      )
                    : Expanded(
                        child: Stack(children: [
                          Column(
                            children: [
                              GestureDetector(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: OutlinedButton(
                                      child: Text(select ? "Select" : "Done",
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
                                        setState(() {
                                          select = !select;
                                          if (!select) {
                                            noOfSelectedPhotos = 0;
                                            isSelected.fillRange(
                                                0, photos.length, false);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: 110 / 140,
                                    children:
                                        List.generate(photos.length, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isSelected[index] =
                                                !isSelected[index];
                                            isSelected[index]
                                                ? noOfSelectedPhotos++
                                                : noOfSelectedPhotos--;

                                            print(noOfSelectedPhotos);
                                          });
                                        },
                                        child: Container(
                                          // if(isSelected[])
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: isSelected[index] &&
                                                          !select
                                                      ? Colors.blue[900]
                                                      : Colors.white,
                                                  width: isSelected[index] &&
                                                          !select
                                                      ? 4
                                                      : 0)),
                                          child: Image.network(photos[index]
                                                  ["sizes"]["size"]["medium"]
                                              ["url"]),
                                        ),
                                      );
                                    })),
                              ),
                              // ],)
                            ],
                          ),
                          Positioned(
                              bottom: 0,
                              child: Visibility(
                                visible: !select && noOfSelectedPhotos > 0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.lock_sharp,
                                            color: Colors.white,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.photo_library_rounded,
                                            color: Colors.white,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                              ))
                        ]),
                      ),
              ]),
            );
          } else
            return LoadingPage();
        });
  }
}
