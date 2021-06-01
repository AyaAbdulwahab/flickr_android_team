class EndPoints {
  static const String baseUrl = "http://192.168.1.7:7000";
  static const String emulatorBaseUrl = "http://10.0.0.2:7000";
  static const String mockBaseUrl =
      "https://c4aca0bd-5ba0-4a26-b6a2-a6b086a3646f.mock.pstmn.io";

  //192.168.1.11
}

class PrivacySettingsView {
  static const List<String> tilesTitles = [
    'Default privacy',
    'Location privacy',
    'Safety level',
    'Import EXIF location data',
    'SafeSeacrh filter'
  ];
  static const List<String> tilesBody = [
    'Choose the default privacy for your manual posts.',
    'Choose who can see the location of photos you post.',
    'Choose a safety level for your posts. This will affect who can see your content based on their SafeSearch filter.',
    'Choose whether or not location information from your photos is uploaded on Flickr.',
    'Choose the level of explicit content shown in search results and feeds'
  ];
  static const List<String> defaultPrivacy = [
    'Public',
    'Private',
    'Friends',
    'Family',
    'Friends & family'
  ];

  static const List<String> locationPrivacy = [
    'Private',
    'Family',
    'Friends',
    'Friends & family',
    'Following',
    'Public',
  ];

  static const List<String> safetyLevel = ['Safe', 'Moderate', 'Restricted'];

  static const List<String> safeSearchFilter = ['On', 'Moderate', 'Off'];
}
