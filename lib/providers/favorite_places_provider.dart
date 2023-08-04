import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlacesNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlacesNotifier(): super([]);

  void addFavoritePlace(FavoritePlace item, {int? index})
  {
    List<FavoritePlace> temp = List.of(state);
    index == null ? temp.add(item) : temp.insert(index, item);
    state = temp;
  }

  void removeFavoritePlace(FavoritePlace item)
  {
    List<FavoritePlace> temp = List.of(state);    
    temp.remove(item);
    state = temp;
  }
  
}

final favoritePlacesProvider = StateNotifierProvider<FavoritePlacesNotifier, List<FavoritePlace>>((ref) {
  return FavoritePlacesNotifier();
});