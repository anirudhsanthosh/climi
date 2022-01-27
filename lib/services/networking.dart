import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> getData(latitude, longitude) async {
  const String appId = 'bd9da732f2b0c3d80b1c803edc02816f';
  print(
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$appId&units=metric');
  var url = Uri.parse(
    'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$appId&units=metric',
  );
  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print('some error in networking');
    print(e);
  }
}
