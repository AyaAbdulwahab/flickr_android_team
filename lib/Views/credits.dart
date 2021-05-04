import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Constants/credits_details.dart';

class Credits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Credits'),
        backgroundColor: Color(0xFF212124),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CreditSection(
                    label: 'Notices for libraries:',
                    bulletPoint: '     • MPAndroidChart',
                    details: mpAndroidChart),
                CreditSection(
                    label: 'Notices for libraries:',
                    bulletPoint: '     • Facebook Shimmer',
                    details: facebookShimmer),
                CreditSection(
                  label: 'Notices for libraries:',
                  bulletPoint: '     • Koin',
                  details: koin,
                ),
                CreditSection(
                  label: 'Notices for libraries:',
                  bulletPoint: '''
       • Picasso 
       • Moshi 
       • Retrofit 
       • OkHttp''',
                  details: picasso,
                ),
                CreditSection(
                  label: 'Notices for libraries:',
                  bulletPoint: '     • AWS Cognito Identity Provider',
                  details: aws,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '''
       • android-support-v13.jar 
       • HeaderGridView.java''',
                  details: android,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • isoparser-1.0-RC-27.jar',
                  details: isoparser,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • gson-2.8.5.jar',
                  details: gson,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • FileUtils.java',
                  details: fileUtils,
                ),
                CreditSection(
                  label: 'Notices for libraries:',
                  bulletPoint: '     • ccv',
                  details: ccv,
                ),
                CreditSection(
                  label: 'Notices for libraries:',
                  bulletPoint: '     • expat',
                  details: expat,
                ),
                CreditSection(
                  label: 'Notices for libraries:',
                  bulletPoint: '     • jansson',
                  details: jansson,
                ),
                CreditSection(
                  label: 'Notices for libraries:',
                  bulletPoint: '     • libjpeg-turbo',
                  details: libjpeg,
                ),
                CreditSection(
                  label: 'Notices for libraries:',
                  bulletPoint: '     • libvpx',
                  details: libvpx,
                ),
                CreditSection(
                  label: 'Notices for libraries:',
                  bulletPoint: '     • openssl',
                  details: openssl,
                ),
                CreditSection(
                  label: 'Notices for libraries:',
                  bulletPoint: '     • Facebook SDK',
                  details: facebookSDK,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • Cropper',
                  details: cropper,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • SlidingTabLayout & SlidingTabStrip',
                  details: sliding,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • Google Breakpad',
                  details: breakpad,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • Chromium',
                  details: chromium,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • libxml',
                  details: libxml,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • libevent',
                  details: libevent,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • modp_b64',
                  details: modpB64,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '''
       • nss 
       • npr''',
                  details: npr,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • zlib',
                  details: zlib,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • protobuf',
                  details: protobuf,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • colorama',
                  details: colorama,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • ashmem',
                  details: ashmem,
                ),
                CreditSection(
                  label: 'Notices for files:',
                  bulletPoint: '     • ICU',
                  details: icu,
                ),
              ]),
        ),
      ),
    );
  }
}

class CreditSection extends StatelessWidget {
  CreditSection(
      {@required this.label,
      @required this.bulletPoint,
      @required this.details});

  final String label;
  final String bulletPoint;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              // fontFamily:'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            bulletPoint,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            color: Colors.grey.shade200,
            padding: EdgeInsets.all(5.0),
            child: Text(
              details,
              style: TextStyle(
                // fontFamily:,
                fontSize: 13.0, fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
        ]);
  }
}
