import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name
  String time; //time in location
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');

      Map data = jsonDecode(response.body);

      //get data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //datetime Object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("Caught error $e");
      time = "Could not get time data";
    }
  }
}
