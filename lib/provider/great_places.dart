import 'package:flutter/cupertino.dart';
import 'package:flutterap/helpers/loctaion_helper.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/dp_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _iteams = [];
  List<Place> get iteams {
    return _iteams;
  }

  Place findById(String id) {
    return _iteams.firstWhere((element) => element.id == id);
  }

  Future<void> addplace(
      String title, File image, PlaceLocation picked_location) async {
    // final address_Google = await Location_Google_Helper.getlocation(
    //     lat: picked_location.latitude, lng: picked_location.longitude);
    final address_Bing = await Location_Bing_Helper.getlocation(
        lat: picked_location.latitude,
        lng: picked_location.longitude);
    final updated_location = PlaceLocation(
        latitude: picked_location.latitude,
        longitude: picked_location.longitude,
        // address: address_Google != null ? address_Google : address_Bing);
        address: address_Bing);

    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        title: title,
        location: updated_location);
    iteams.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndAetPlaces() async {
    final db = await DBHelper.getData('user_places');
    _iteams = db
        .map((item) => Place(
            id: item['id'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
            title: item['title']))
        .toList();
    notifyListeners();
  }
}
