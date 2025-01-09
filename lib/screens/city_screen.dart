import 'package:flutter/material.dart';
import 'package:w_app/utilities/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('imagenes/cascada.jpg'), // Ruta correcta según tu estructura
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: null,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: TextField(
                  onChanged: (value) {
                    cityName = value;
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ingresa el nombre de la ciudad',
                    hintStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.location_city,
                      color: Colors.blue,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue.shade200,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 20.0,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
