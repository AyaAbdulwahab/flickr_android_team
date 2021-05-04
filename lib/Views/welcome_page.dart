import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Page extends StatelessWidget {
  Page({
    @required this.image,
    @required this.title,
    @required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 378.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23.0,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              subtitle,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class GetStarted extends StatelessWidget {
  final PageController _controller = new PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              // scrollDirection: Axis.horizontal,
              children: [
                Page(
                    image: 'assets/image_part_001.jpg',
                    title: 'Powerful',
                    subtitle: 'Save all your photos and\nvideos in one place.'),
                Page(
                    image: 'assets/image_part_002.jpg',
                    title: 'Organization simplified',
                    subtitle: 'Search, edit, and organize in\nseconds.'),
                Page(
                    image: 'assets/image_part_003.jpg',
                    title: 'Keep your memories safe',
                    subtitle:
                        'Your uploaded photos stay\nprivate until you choose to\nshare them.'),
                Page(
                    image: 'assets/image_part_004.jpg',
                    title: 'Sharing made easy',
                    subtitle: 'Share with friends, family, and\nthe world.'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'flickr',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 70.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 530.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 65.0),
                      child: Text(
                        'Get Started',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white, width: 1.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 500.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: _controller, // PageController
                    count: 4,
                    effect: ScrollingDotsEffect(
                        radius: 4,
                        dotHeight: 8,
                        dotWidth: 8,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.white),
                    onDotClicked: (index) => _controller.animateToPage(index,
                        // curve: Interval(),
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 100)),
                  ), // your preferred effect
                  // onDotClicked: (index){
                  // }
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 630.0, left: 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 15.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Ben Flasher',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
