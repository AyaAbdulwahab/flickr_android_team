// import 'package:http/http.dart' as http;

class User {
  String username;
  String firstname;
  String lastname;
  bool pro;
  String aboutme;
  String joindate;
  String profileurl;
  String location;

  User(
      {this.username,
      this.firstname,
      this.lastname,
      this.pro,
      this.aboutme,
      this.joindate,
      this.profileurl,
      this.location});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        pro: json['pro'],
        aboutme: json['aboutme'] ?? " ",
        joindate: json['joindate'],
        profileurl: json['profileurl'],
        location: json['location']);
  }
}
