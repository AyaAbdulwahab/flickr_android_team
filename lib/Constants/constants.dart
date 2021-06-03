class EndPoints {
  static const String baseUrl = "https://www.flickrclone.tech/api/";
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
    'SafeSearch filter'
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
    'Contacts Only',
    'Friends & family',
    'Friends',
    'Family',
    'Friends & family'
  ];

  static const List<String> locationPrivacy = [
    'Private',
  ];

  static const List<String> safetyLevel = ['Safe', 'Moderate', 'Restricted'];

  static const List<String> safeSearchFilter = ['On', 'Off'];
}

// Static Images to be changed later
List<String> images = [
  "assets/p1.jpg",
  "assets/p2.png",
  "assets/Portrait.jpg",
  "assets/port2.jpg",
  "assets/p4.jpg",
  "assets/p5.jpg",
  "assets/panda.jpg",
  "assets/zootopia.jpg",
  "assets/Rick.jpg",
  "assets/hades.jpg",
  "assets/p10.jpg"
];
List<String> searchedImages = [
  "assets/search1.jpg",
  "assets/search2.jpg",
  "assets/search3.jpg",
  "assets/search4.jpg",
  "assets/search5.png",
  "assets/p10.jpg",
  "assets/hades.jpg",
  "assets/p2.png"
];
List<String> peopleNames = [
  "Spongebob",
  "Donald Duck",
  "Buzz Lightyear",
  "Monalisa",
  "Nemo",
  "Timon"
];
List<String> profilePhotos = [
  "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
  "https://upload.wikimedia.org/wikipedia/en/a/a5/Donald_Duck_angry_transparent_background.png",
  "https://i.pinimg.com/originals/0e/81/53/0e8153e8a2c62459ca24a06ca9fb7069.png",
  "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/1200px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg",
  "https://stickershop.line-scdn.net/stickershop/v1/product/1348/LINEStorePC/main.png;compress=true",
  "https://i1.sndcdn.com/avatars-000514838841-sk6ksb-t500x500.jpg"
];
List<String> photosNumber = ["50", "13", "120", "3", "5", "89"];
List<String> followers = ["1.3K", "14k", "15K", "200", "983", "15K"];
List<String> groupsNames = [
  "Group1",
  "Group2",
  "Group3",
  "Group4",
  "Group5",
  "Group6"
];
List<String> groupsMembers = ["100", "10k", "564", "9k", "10", "34"];
List<String> groupsDiscussions = ["13", "110", "54", "45", "123", "78"];
List<String> groupsPhotos = ["91", "16.2k", "54", "9k", "10", "143"];
