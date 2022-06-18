import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(24.142, -110.321),
            zoom: 15
          )
        )
      ],
    );
  }
}