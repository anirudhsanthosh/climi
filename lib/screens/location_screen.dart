import 'package:climi/services/weather.dart';
import 'package:climi/utilities/constants.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeatherData});

  final dynamic locationWeatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 30;
  int condition = 300;
  String? cityname;
  String? weatherDescription;
  String? weatherIcon;
  String? weatherStatus;
  void initState() {
    super.initState();
    updateUI(widget.locationWeatherData);
  }

  void updateUI(dynamic weatherData) {
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
    condition = weatherData['weather'][0]['id'];
    cityname = weatherData['name'];
    weatherDescription = weatherData['weather'][0]['main'];
    weatherIcon = weather.getWeatherIcon(condition);
    weatherStatus = weather.getMessage(temperature);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weatherStatus.toString()} in $cityname!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
