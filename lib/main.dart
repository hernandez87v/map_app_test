import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  late GoogleMapController _controller;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(49.274875741657354, -123.1035166857423),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(49.271187266841416, -123.01609499352571),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Marker> _createMarker() {
    return {
      Marker(
        markerId: const MarkerId("Work"),
        position: const LatLng(49.271187266841416, -123.01609499352571),
        infoWindow: const InfoWindow(title: 'Metro Traffic Management'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
      const Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(50.271187266841416, -123.01609499352571),
      ),
    };
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: onMapCreated,
        // mapType: MapType.hybrid,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _createMarker(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('Metro Traffic'),
        icon: const Icon(Icons.work),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = _controller;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
