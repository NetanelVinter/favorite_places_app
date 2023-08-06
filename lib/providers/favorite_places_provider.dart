import 'dart:io';

import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import '../api/favorite_place_api.dart';


class FavoritePlacesNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final sql.Database dataBase = await FavoritePlaceApi.dataBase;

    final List<Map<String, Object?>> data = await dataBase.query('Places');

    final List<FavoritePlace> places = data
        .map((row) => FavoritePlace(
              id: row['id'] as String,
              name: row['title'] as String,
              image: File(row['image'] as String),
              placeLocation: PlaceLocation(
                  latitude: row['lat'] as double,
                  longitude: row['lng'] as double,
                  address: row['address'] as String),
            ))
        .toList();

    state = places;
  }

  Future<void> addFavoritePlace(FavoritePlace item, {int? index}) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();    
    final imageFileName = path.basename(item.image.path);
    final imageDup = await item.image.copy('${appDir.path}/$imageFileName');

    final newPlace = FavoritePlace(
        name: item.name, image: imageDup, placeLocation: item.placeLocation);    

    await FavoritePlaceApi.insert({
      'id': newPlace.id,
      'title': newPlace.name,
      'image': newPlace.image.path,
      'lat': newPlace.placeLocation.latitude,
      'lng': newPlace.placeLocation.longitude,
      'address': newPlace.placeLocation.address
    });

    List<FavoritePlace> temp = List.of(state);
    index == null ? temp.add(newPlace) : temp.insert(index, newPlace);
    state = temp;
  }

  Future<void> removeFavoritePlace(FavoritePlace item, {int? index}) async {
    await item.image.delete();    
    
    await FavoritePlaceApi.deleteById(item.id);

    List<FavoritePlace> temp = List.of(state);
    index == null ? temp.remove(item) : temp.removeAt(index);
    state = temp;
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<FavoritePlace>>((ref) {
  return FavoritePlacesNotifier();
});
