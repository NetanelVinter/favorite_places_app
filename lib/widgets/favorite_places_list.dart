import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:favorite_places_app/providers/favorite_places_provider.dart';
import 'package:favorite_places_app/widgets/favorite_place_tile.dart';

class FavoritePlacesList extends ConsumerWidget {
  const FavoritePlacesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FavoritePlace> favoriteList = ref.watch(favoritePlacesProvider);
    return ListView.builder(
      itemCount: favoriteList.length,
      itemBuilder: (context, index) {
        return FavoritePlaceTile(favoriteList[index]);
      },
    );
  }
}
