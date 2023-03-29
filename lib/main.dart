import 'package:flutter/material.dart';
import 'package:geolocator_test/home.dart';

void main() {
  runApp(const GeolocatorTest());
}

class GeolocatorTest extends StatelessWidget {
  const GeolocatorTest({super.key});

  @override
  Widget build(BuildContext context) {
    String address = "";

    return const MaterialApp(home: HomePage());
  }
}
