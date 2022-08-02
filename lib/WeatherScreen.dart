import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("Weather"),);
  }
}
