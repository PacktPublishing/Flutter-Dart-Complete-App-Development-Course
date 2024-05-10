import 'package:been_here_go/components/image_stack.dart';
import 'package:been_here_go/components/text_container.dart';
import 'package:been_here_go/models/place.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final place = ModalRoute.of(context)!.settings.arguments as Place;

    double lat = double.parse(place.latitude.toString());
    double lon = double.parse(place.longitude.toString());
    //String apiKey = 'ADD Your OWnKEY-yuEcNQFxal0fNw';
    String apiKey = 'AIzaSyCbN1RJoKXrWSBNPqBV-yuEcNQFxal0fNw';

    String staticMapUrl = 'https://maps.googleapis.com/maps/api/staticmap?'
        'center=$lat,$lon'
        '&zoom=13'
        '&size=600x300'
        '&maptype=roadmap'
        '&markers=color:red%7Clabel:S%7C$lat,$lon'
        '&key=$apiKey';

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: ImageStack(
                  place: place,
                  metadata: 'Visite on:',
                ),
              ),
            ),
            TextContainer(
              content: place.description,
              header: 'Description',
            ),
            TextContainer(
              content: place.thoughts,
              header: 'Thoughts',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(staticMapUrl),
            )
          ],
        ),
      ),
    );
  }
}
