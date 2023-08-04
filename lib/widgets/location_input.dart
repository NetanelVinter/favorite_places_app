import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({required this.onLocationSave, super.key});

  final void Function(PlaceLocation place) onLocationSave;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool isGettingLocation = false;
  PlaceLocation? placeLocation;

  String get imageMapUrl {
    final lat = placeLocation!.latitude;
    final lng = placeLocation!.longitude;

    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=${dotenv.get('API_KEY')}";
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation = true;
    });

    LocationData locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    final uri = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${dotenv.get('API_KEY')}");

    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final address = json['results'][0]['formatted_address'];

    setState(() {
      placeLocation =
          PlaceLocation(latitude: lat!, longitude: lng!, address: address);
      isGettingLocation = false;
    });

    widget.onLocationSave(placeLocation!);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContect = isGettingLocation == false
        ? Text(
            "Location",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20),
          )
        : const CircularProgressIndicator();

    if (placeLocation != null) {
      previewContect = CachedNetworkImage(
        imageUrl: imageMapUrl,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        progressIndicatorBuilder: (context, url, progress) =>
            CircularProgressIndicator(
          value: progress.progress,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }

    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.5))),
            height: 200,
            width: double.infinity,
            child: previewContect),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: Text('Get current location',
                  style: Theme.of(context).textTheme.titleSmall),
            ),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: Text('Select on map',
                    style: Theme.of(context).textTheme.titleSmall)),
          ],
        )
      ],
    );
  }
}
