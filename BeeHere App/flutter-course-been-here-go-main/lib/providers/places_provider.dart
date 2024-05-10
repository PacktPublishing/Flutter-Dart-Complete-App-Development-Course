import 'package:been_here_go/models/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlacesProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Place>> fetchPlaces(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('places')
          .where('userId', isEqualTo: userId)
          .get();

      List<Place> places = querySnapshot.docs
          .map((doc) => Place.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      print("Places ===> $userId ${places.toString()}");

      return places;
    } catch (error) {
      throw Exception('Failed to fetch places $error');
    }
  }
}
