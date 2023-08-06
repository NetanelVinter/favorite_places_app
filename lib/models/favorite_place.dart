import 'dart:io';
import 'package:uuid/uuid.dart';

class PlaceLocation 
{
  const PlaceLocation({required this.latitude, required this.longitude, required this.address});
  
  final double latitude;
  final double longitude;
  final String address;

}

class FavoritePlace
{
  FavoritePlace({required this.name, required this.image, required this.placeLocation, String? id}) : id = id ?? const Uuid().v4();
  
  final String id;   
  final String name;
  final File image;
  final PlaceLocation placeLocation;

}