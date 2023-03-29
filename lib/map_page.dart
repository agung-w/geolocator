import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class MapPage extends StatefulWidget {
  final LatLng initLocation;
  const MapPage({super.key, required this.initLocation});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? pinLocation;
  @override
  void initState() {
    pinLocation = widget.initLocation;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap to add pins')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Text('Tap to add pins'),
            ),
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: pinLocation,
                  zoom: 18,
                  maxZoom: 18,
                  minZoom: 6,
                  onTap: _handleTap,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  if (pinLocation != null) ...{
                    MarkerLayer(markers: [
                      Marker(
                        width: 80,
                        height: 80,
                        point: pinLocation!,
                        builder: (ctx) => const Icon(Icons.point_of_sale),
                      )
                    ]),
                  }
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    log(latlng.toString());
    setState(() {
      pinLocation = latlng;
    });
  }
}
