import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(uri: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(uri: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(uri: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(uri: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(uri: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(uri: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(uri: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(uri: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    //navigate to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            child: Card(
                child: ListTile(
              onTap: () {
                updateTime(index);
              },
              title: Text(locations[index].location),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/${locations[index].flag}'),
              ),
            )),
          );
        },
      ),
    );
  }
}
