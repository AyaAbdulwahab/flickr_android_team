import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';
import 'package:flickr/Models/privacy_info_model.dart';

import 'package:http/http.dart' as http;

/// Sends PATCH request with [token] and [ID] as headers for updating privacy settings using the [PrivacyInfo] parameter
///
/// Returns [PrivacyInfo] Object with the new privacy settings obtained from the response
Future updatePrivacy(PrivacyInfo info, String token) async {
  try {
    print("PATCH Request...");
    final response = await Dio().patch(EndPoints.baseUrl + '/user/perm',
        options: Options(
            headers: {"authorization": "Bearer " + token},
            validateStatus: (_) {
              return true;
            },
            responseType: ResponseType.json),
        data: jsonEncode(
          {
            "privacySettings": {
              "defaults": {
                "perms": {
                  "see": info.def,
                  "comment": info.def,
                  "addNotes": info.def,
                },
                "mapVisible": info.location,
                "importEXIF": info.importEXIF,
                "safetyLevel": info.safetyLevel,
              },
              "filters": {
                "search": {"safetySearch": info.safeSearch == 1 ? true : false}
              }
            },
          },
        ));
    var responseBody = response.data;
    if (response.statusCode == 200) {
      return PrivacyInfo.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception('An error occured');
    }
  } catch (error) {
    print(error);
  }
}

/// Sends GET request for obtaining privacy settings using the [PrivacyInfo] parameter
///
/// Returns [PrivacyInfo] Object that contains the privacy settings obtained from the response
Future<PrivacyInfo> getPrivacy(String token) async {
  final response = await http.get(
    Uri.parse(EndPoints.baseUrl + '/user/perm'),
    headers: {"authorization": "Bearer " + token},
  );

  if (response.statusCode == 200) {
    return PrivacyInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('An error occurred');
  }
}
