import 'dart:ui';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String uri; //location url for api endpoint
  bool isDayTime; //day or not

  WorldTime({
    this.location = '',
    this.time = '',
    this.flag = '',
    this.uri = '',
    bool? isDayTime,
  }): this.isDayTime = isDayTime ?? false;

  Future<void> getTime() async {
    try {
      final url = Uri.parse('http://worldtimeapi.org/api/timezone/$uri');
      http.Response response = await http.get(url);
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //Create a datetime obj
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));


      isDayTime = now.hour > 6 && now.hour < 15 ? true: false;

      String ok;
      ok = DateFormat.jm().format(now);
      //set the time property
      time = ok;
    } catch (e) {
      print('Caught error: $e');
      time= 'could not get time data';
    }
  }
}
