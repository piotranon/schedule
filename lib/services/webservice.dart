import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:schedule/models/models.dart';

class Webservice {
  Future<List<Schedule>> getSchedule() async {
    final response = await http.get('http://10.0.2.2:8000/lecture/');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      print("response: " + response.toString());
      print("dane: " + json.toString());
      // return json.map((weekDay)=> WeekDay.from)
    }
  }
}
