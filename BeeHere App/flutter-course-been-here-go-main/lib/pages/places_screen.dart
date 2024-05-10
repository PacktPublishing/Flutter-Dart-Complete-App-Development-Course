import 'package:been_here_go/components/place_tile.dart';
import 'package:been_here_go/components/star_rating.dart';
import 'package:been_here_go/models/place.dart';
import 'package:been_here_go/providers/auth_provider.dart';
import 'package:been_here_go/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context, listen: false).user!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
      ),
      body: Consumer<PlacesProvider>(
        builder: (context, value, child) {
          final places = value.fetchPlaces(userId);
          return FutureBuilder<List<Place>>(
            future: places,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final places = snapshot.data!;

                if (places.isEmpty) {
                  return const Center(
                    child: Text('No places Found'),
                  );
                }

                return GridView.custom(
                  gridDelegate: SliverStairedGridDelegate(
                    crossAxisSpacing: 48,
                    mainAxisSpacing: 24,
                    startCrossAxisDirectionReversed: true,
                    pattern: [
                      const StairedGridTile(0.5, 1),
                      const StairedGridTile(0.5, 3 / 4),
                      const StairedGridTile(1.0, 10 / 4),
                    ],
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    childCount: places.length,
                    (context, index) {
                      final place = places[index];
                      return PlaceTile(
                        place: place,
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text('No places found'),
                );
              }
            },
          );
        },
      ),
    );
  }
}
