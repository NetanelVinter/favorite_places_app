import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  MapScreen(
      {this.placeLocation = const PlaceLocation(
          latitude: 37.422, longitude: -122.084, address: ''),
      this.isSelecting = true,
      super.key});

  PlaceLocation placeLocation;
  bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick Your Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () => Navigator.of(context).pop(pickedLocation),
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting ? null : (pos) => setState(() {
          pickedLocation = pos;
        }),
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.placeLocation.latitude,
            widget.placeLocation.longitude,
          ),
          zoom: 16,
        ),
        markers: (pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: pickedLocation ??
                      LatLng(widget.placeLocation.latitude,
                          widget.placeLocation.longitude),
                ),
              },
      ),
    );
  }
}
