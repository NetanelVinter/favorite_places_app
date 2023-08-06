import 'dart:io';

import 'package:favorite_places_app/models/favorite_place.dart';
import 'package:favorite_places_app/providers/favorite_places_provider.dart';
import 'package:favorite_places_app/widgets/image_input.dart';
import 'package:favorite_places_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return AddPlaceScreenState();
  }
}

class AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final globalKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  File? selectedImage;
  PlaceLocation? selectedPlace;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void saveItem(BuildContext ctx) {
    if (globalKey.currentState!.validate() || selectedImage != null) {
      FavoritePlace itemToAdd =
          FavoritePlace(image: selectedImage!, name: titleController.text, placeLocation: selectedPlace!);
      ref.read(favoritePlacesProvider.notifier).addFavoritePlace(itemToAdd);
      Navigator.of(ctx).pop();
    }
  }

  void resetItem() {
    globalKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Favorite Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              TextFormField(
                style: Theme.of(context).textTheme.titleMedium,
                controller: titleController,
                decoration: const InputDecoration(label: Text('Title')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'Enter name bigger than 1 character';
                  }
                  return null;
                },
                onSaved: (newValue) => titleController.text = newValue!,
              ),
              const SizedBox(height: 15),
              ImageInput(onSelectedImage: (image) => selectedImage = image),
              const SizedBox(height: 20),
              LocationInput(onLocationSave: (place) => selectedPlace = place,),
              //const SizedBox(height: 20),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: resetItem,
                    child: const Text(
                      'Reset',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 30),                  
                  ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () => saveItem(context),
                      label: const Text('Save', style: TextStyle(fontSize: 16),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
