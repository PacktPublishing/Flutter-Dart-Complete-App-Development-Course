import 'package:been_here_go/components/star_rating.dart';
import 'package:been_here_go/models/place.dart';
import 'package:flutter/material.dart';

class ImageStack extends StatelessWidget {
  final String? metadata;
  const ImageStack({
    super.key,
    required this.place,
    this.metadata,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    // Unsplash image URL for placeholder
    const String unsplashPlaceholderUrl =
        'https://source.unsplash.com/random/800x600';

    String contentWidget;
    if (metadata == null) {
      contentWidget = place.createdAt!.toDate().toIso8601String().split('T')[0];
    } else {
      contentWidget =
          '$metadata ${place.createdAt!.toDate().toIso8601String().split('T')[0]}';
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned.fill(
            child: Image.network(
          place.imageUrl ?? unsplashPlaceholderUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.network(
            unsplashPlaceholderUrl,
            fit: BoxFit.cover,
          ),
        )),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          color: Colors.black.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OverflowBar(
                spacing: 8,
                children: [
                  place.createdAt != null
                      ? Text(
                          contentWidget,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        )
                      : const Text("") //12/45/234TTZsdadf
                ],
              ),
              const Spacer(),
              Text(
                place.name,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
              StarRating(rating: place.rating.toInt()),
            ],
          ),
        )
      ],
    );
  }
}
