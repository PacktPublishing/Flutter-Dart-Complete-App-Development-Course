import 'package:been_here_go/providers/auth_provider.dart';
import 'package:been_here_go/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PlacesMapView extends StatefulWidget {
  const PlacesMapView({super.key});

  @override
  State<PlacesMapView> createState() => _PlacesMapViewState();
}

class _PlacesMapViewState extends State<PlacesMapView> {
  late GoogleMapController? mapController;
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  @override
  void initState() {
    final userId = Provider.of<AuthProvider>(context, listen: false).user!.uid;
    final placesProvider = Provider.of<PlacesProvider>(context, listen: false);

    placesProvider.fetchPlaces(userId).then((value) {
      setState(() {
        _markers.clear();
        for (var place in value) {
          final marker = Marker(
              markerId: MarkerId(place.docId!),
              position: LatLng(double.parse(place.latitude!),
                  double.parse(place.longitude!)),
              infoWindow:
                  InfoWindow(title: place.name, snippet: place.description));

          _markers[place.docId!] = marker;
          // print('Places found::: ${place.latitude}');
        }
      });

      // zom to the first marker when places are loaded
      if (_markers.isNotEmpty) {
        final firstMarker = _markers.entries.first;
        final initialCameraPosition =
            CameraPosition(target: firstMarker.value.position, zoom: 13);

        mapController?.animateCamera(
            CameraUpdate.newCameraPosition(initialCameraPosition));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const center = LatLng(0.0, 0.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places You\'ve Been'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(target: center, zoom: 10),
        markers: _markers.values.toSet(),
      ),
    );
  }
}
