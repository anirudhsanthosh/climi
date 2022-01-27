import 'package:climi/screens/location_screen.dart';
import 'package:climi/services/location.dart';
import 'package:climi/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;
  String? city;
  double? temperature;
  int? condition;
  var weatherDescription;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    Location location = Location();
    await location.get();
    latitude = location.latitude;
    longitude = location.longitude;
    // ['latitude: ', latitude, 'longitude: ', longitude].forEach(print);
    var data = await getData(latitude, longitude);
    // print(data);
    setState(() {
      weatherDescription = data['weather'][0]['main'];
      city = data['name'];
      temperature = data['main']['temp'];
      condition = data['weather'][0]['id'];
    });

    // print(weatherDescription);
    // print(city);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeatherData: data);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SpinKitRotatingCircle(
                color: Colors.white,
                size: 50.0,
              ),
              // Text('city: $city, weather: $weatherDescription'),
              // ElevatedButton(
              //   onPressed: getData,
              //   child: Text('Get Location'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
