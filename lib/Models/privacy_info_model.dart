import 'package:flutter/material.dart';

/// The [PrivacyInfo] class holds the privacy data obtained for the user
///
/// Is used for sending privacy requests and parsing data from responses
class PrivacyInfo {
  int def;
  int location;
  int safetyLevel;
  bool importEXIF;
  int safeSearch;
  PrivacyInfo({
    @required this.def,
    @required this.location,
    @required this.safetyLevel,
    @required this.importEXIF,
    @required this.safeSearch,
  });

  factory PrivacyInfo.fromJson(Map<String, dynamic> json) {
    bool jsonSafeS =
        json['data']['privacySettings']['filters']['search']['safeSearch'];
    // print(json['data']['privacySettings']['defaults']['importEXIF']);
    int safeS;
    if (jsonSafeS == true) {
      safeS = 1;
    } else {
      safeS = 2;
    }

    return PrivacyInfo(
      def: json['data']['privacySettings']['defaults']['perms']['see'],
      location: json['data']['privacySettings']['defaults']['mapVisible'],
      importEXIF: json['data']['privacySettings']['defaults']['importEXIF'],
      safetyLevel: json['data']['privacySettings']['defaults']['safetyLevel'],
      safeSearch: safeS,
    );
  }
}
