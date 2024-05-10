import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  final String name;
  final String description;
  final String thoughts;
  final double rating;
  final String? imageUrl;
  final String? userId;
  final String? currentAddress;
  final String? longitude;
  final String? latitude;
  final Timestamp? createdAt;
  final String? docId;

  Place(
      {required this.name,
      required this.description,
      required this.thoughts,
      required this.rating,
      this.imageUrl,
      this.userId,
      this.currentAddress,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.docId});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'] as String,
      description: json['description'] as String,
      thoughts: json['thoughts'] as String,
      rating: json['rating'] as double,
      imageUrl: json['imageUrl'] as String?,
      userId: json['userId'] as String?,
      currentAddress: json['currentAddress'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      createdAt: json['createdAt'] as Timestamp?,
      docId: json['docId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'thoughts': thoughts,
      'rating': rating,
      'imageUrl': imageUrl, // This will be null if imageUrl is not set
      'userId': userId,
      'currentAddress': currentAddress,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': Timestamp.now(),
      'docId': docId,
    };
  }
}
