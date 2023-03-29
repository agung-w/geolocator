import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_test/map_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String address = "";
    return Scaffold(
      body: Center(
        child: Column(children: [
          ElevatedButton(
              onPressed: () async {
                var currentLocation = await _determinePosition();
                log(currentLocation.toString());
              },
              child: const Text("Tes")),
          TextField(
            onChanged: (value) => address = value,
          ),
          ElevatedButton(
              onPressed: () async {
                Location locations = await _determineLocationByAddress(address);
                log(locations.toString());
              },
              child: const Text("Tes")),
          ElevatedButton(
              onPressed: () async {
                List<Placemark> locations = await placemarkFromCoordinates(
                    33.6149136, -78.98028959999999);

                log(locations.last.toString());
              },
              child: const Text("Tes")),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MapPage(),
                ));
              },
              child: const Text("Open Map")),
        ]),
      ),
    );
  }
}

Future<Location> _determineLocationByAddress(String address) async {
  try {
    var locations = await locationFromAddress(address);
    return locations.first;
  } catch (e) {
    return Future.error('Location cant be found');
  }
}

Future<Placemark> _determineAddressByLocation(
    double latitude, double longitude) async {
  try {
    var address = await placemarkFromCoordinates(latitude, longitude);
    return address.first;
  } catch (e) {
    return Future.error('Location cant be found');
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Geolocator.openAppSettings();
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
