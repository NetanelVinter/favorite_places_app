import 'package:favorite_places_app/screens/add_place_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/favorite_places_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(        
        title: const Text('Favorite Places'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AddPlaceScreen())),
              icon: const Icon(Icons.add))
        ],
      ),
      body: const FavoritePlacesList(),
      
    );
  }
}
