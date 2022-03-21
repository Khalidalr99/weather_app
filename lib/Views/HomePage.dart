import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? _position;
  double? temp;
  String? location;

  void getCurrentLocation() async {
    await Geolocator.requestPermission();
    await Geolocator.checkPermission();
    _position = await Geolocator.getCurrentPosition();
    Response response;
    if (_position != null) {
      if (_position!.latitude != null) {
        response = await http.get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=${_position!.latitude}&lon=${_position!.longitude}&appid=6787238ffaefd09750c8043f4ba072dd"));
        final json = jsonDecode(response.body);
        setState(() {
          temp = json["main"]["temp_max"];
          location =json["name"];
        });


      }
    }
    setState(() {});
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "Your location is: ${_position.toString()}",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async => getCurrentLocation(),
              child: Container(
                  child: Center(
                      child: const Text(
                    "Get location",
                  )),
                  height: 50,
                  width: 200,
                  color: Colors.green),
            ),
            temp!= null ?Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                "The Temp in $location is $temp",
                textAlign: TextAlign.center,
              ),
            ):SizedBox(),
          ],
        ),
      ),
    );
  }
}
