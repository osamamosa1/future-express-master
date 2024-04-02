import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class Restaurant {
  final LatLng location;
  final int orderCount;

  Restaurant(this.location, this.orderCount);
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  final restaurants = [
    Restaurant(const LatLng(37.4219999, -122.0840575), 15),

    Restaurant(const LatLng(37.42796133580664, -122.085749655962), 3),
    Restaurant(const LatLng(37.4287036, -122.0817803), 20),
    Restaurant(const LatLng(37.4287707, -122.082651), 12),

    Restaurant(const LatLng(37.42691133580664, -122.583749655962), 15),
    Restaurant(const LatLng(37.42196133580664, -122.0883749655962),8),
    Restaurant(const LatLng(37.41696133580664, -122.183749655962), 6),
    Restaurant(const LatLng(37.8896133580664, -122.085), 9),
    Restaurant(const LatLng(37.33196133580664, -122.223749655962), 15),

    // New restaurants
    Restaurant(const LatLng(37.4319999, -122.0840575), 20),
    Restaurant(const LatLng(37.4327036, -122.0817803), 12),
    Restaurant(const LatLng(37.4327707, -122.082651), 13),
    Restaurant(const LatLng(37.43691133580664, -122.583749655962), 14),

    // Add more restaurants...
  ];

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  Future<void> _createMarkers() async {
    for (var restaurant in restaurants) {
      final markerId = MarkerId(restaurant.location.toString());
      final marker = Marker(
        markerId: markerId,
        position: restaurant.location,
        icon: await _createMarkerIcon(restaurant.orderCount),
      );

      _markers.add(marker);
    }
    setState(() {});
  }

  Future<BitmapDescriptor> _createMarkerIcon(int orderCount) async {
    const size = 80.0;
    final markerImage = await _getMarkerImage(orderCount, size);
    return BitmapDescriptor.fromBytes(markerImage);
  }

  Future<Uint8List> _getMarkerImage(int orderCount, double size) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    // Calculate alpha based on order count
    final alpha = (orderCount / 25).clamp(0.1, 1.0);
    final color = Colors.red.withOpacity(alpha);

    final markerRadius = size / 2;
    final markerCenter = Offset(markerRadius, markerRadius);

    final paint = Paint()..color = color;

    // Draw a hexagon
    final hexagonPath = Path();
    for (int i = 0; i < 7; i++) {
      final angle = (pi / 3.0) * i;
      final x = markerCenter.dx + markerRadius * cos(angle);
      final y = markerCenter.dy + markerRadius * sin(angle);
      if (i == 0) {
        hexagonPath.moveTo(x, y);
      } else {
        hexagonPath.lineTo(x, y);
      }
    }
    hexagonPath.close();
    canvas.drawPath(hexagonPath, paint);

    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(size.toInt(), size.toInt());
    final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }

  Future<ui.Image> loadImage(ImageProvider imageProvider) async {
    final completer = Completer<ui.Image>();
    final stream = imageProvider.resolve(const ImageConfiguration());

    stream.addListener(ImageStreamListener(
      (info, _) async {
        final img = await info.image.toByteData(format: ui.ImageByteFormat.png);
        final codec = await ui.instantiateImageCodec(
            Uint8List.sublistView(img!.buffer.asUint8List()));

        final frameInfo = await codec.getNextFrame();
        completer.complete(frameInfo.image);
      },
    ));

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: restaurants[0].location,
        zoom: 14.0,
      ),
      markers: _markers,
    );
  }
}
