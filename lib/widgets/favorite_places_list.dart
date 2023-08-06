import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:favorite_places_app/providers/favorite_places_provider.dart';
import 'package:favorite_places_app/widgets/favorite_place_tile.dart';

class FavoritePlacesList extends ConsumerStatefulWidget {
  const FavoritePlacesList({super.key});

  @override
  ConsumerState<FavoritePlacesList> createState() {
    return FavoritePlacesListState();
  }
}

class FavoritePlacesListState extends ConsumerState<FavoritePlacesList> {
  late Future<void> loadFromDataBase;

  @override
  void initState() {
    super.initState();
    loadFromDataBase = ref.read(favoritePlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    List<FavoritePlace> favoriteList = ref.watch(favoritePlacesProvider);

    return FutureBuilder(
      future: loadFromDataBase,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: favoriteList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: Key(favoriteList[index].id),
                  onDismissed: (direction) async {
                    await ref
                        .read(favoritePlacesProvider.notifier)
                        .removeFavoritePlace(favoriteList[index], index: index);

                    setState(() {});

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('${favoriteList[index].name} dismissed.')));
                  },
                  child: FavoritePlaceTile(favoriteList[index]));
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
