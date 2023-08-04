import 'package:cached_network_image/cached_network_image.dart';
import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:favorite_places_app/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DetailPlaceScreen extends StatelessWidget {
  const DetailPlaceScreen(this.place, {super.key});

  final FavoritePlace place;

  String get imageMapUrl {
    final lat = place.placeLocation.latitude;
    final lng = place.placeLocation.longitude;

    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=${dotenv.get('API_KEY')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        isSelecting: false,
                        placeLocation: place.placeLocation,
                      ),
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: CachedNetworkImageProvider(
                      imageMapUrl,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black54, Colors.black12],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter),
                  ),
                  child: Text(
                    place.placeLocation.address,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
