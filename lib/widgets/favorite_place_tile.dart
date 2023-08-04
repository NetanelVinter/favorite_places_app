import 'package:flutter/material.dart';

import '../models/favorite_place.dart';
import '../screens/detail_place_screen.dart';

class FavoritePlaceTile extends StatelessWidget {
  const FavoritePlaceTile(this._place, {super.key});

  final FavoritePlace _place;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailPlaceScreen(_place),
        )),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: FileImage(_place.image),
        ),
        title: Text(
          _place.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          _place.placeLocation.address,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        trailing: const Icon(
          Icons.arrow_right_alt,
          size: 40,
        ),
      ),
    );
  }
}
