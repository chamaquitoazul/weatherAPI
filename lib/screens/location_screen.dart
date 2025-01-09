import 'package:flutter/material.dart';
import 'package:w_app/services/weather.dart';
import '../services/location.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  String cityName = '';
  String weatherMessage = '';
  String weatherIcon = '';
  int temperature = 0;

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      setState(() {
        temperature = 0;
        weatherMessage = 'Unable to get weather data.';
        weatherIcon = '😖‍';
        cityName = '';
      });
      return;
    }

    setState(() {
      temperature = weatherData['main']['temp'].toInt();
      cityName = weatherData['name'];
      weatherIcon = weatherModel.getWeatherIcon(weatherData['weather'][0]['id']);
      weatherMessage = weatherModel.getMessage(temperature) + ' in $cityName!';
    });
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
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getWeatherData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var selectedCity = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }));
                      if (selectedCity != null) {
                        //Si hay algo escrito, retorna la temperatura de dicha ciudad, si existe.
                        var weatherData = await weatherModel.getCityWeather(selectedCity);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text('$temperature°', style: kTempTextStyle,),
                    Text(weatherIcon, style: kConditionTextStyle,),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text("$weatherMessage", textAlign: TextAlign.right, style: kMessageTextStyle,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}