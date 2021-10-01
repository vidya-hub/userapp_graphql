import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  late http.Response response;
  Future login(Map<String, String> userBody) async {
    Uri loginUrl = Uri.parse("https://sparepayapi.herokuapp.com/login");
    response = await http.post(
      loginUrl,
      body: userBody,
    );
    // print(response);
    return json.decode(response.body);
  }

  Future register(Map<String, String> userBody) async {
    Uri regUrl = Uri.parse("https://sparepayapi.herokuapp.com/register");
    print(userBody);
    response = await http.post(
      regUrl,
      body: userBody,
    );
    print("===============");
    print(response.body);
    print("===============");

    return json.decode(response.body);
  }
}
