import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  Future getData() async {
    var uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    return response;
  }

  Future postData(Map<String, dynamic> body) async {
    var uri = Uri.parse(url);
    var response = await http.post(uri, body: body);

    return response;

    // if (response.statusCode==200)
    // {
    //   String data=response.body;
    //   return jsonDecode(data);
    //
    // }
    // else
    // {
    //   print(response.statusCode);
    // }
  }
}
