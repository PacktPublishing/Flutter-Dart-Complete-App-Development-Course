import 'package:been_here_go/components/image_stack.dart';
import 'package:been_here_go/models/place.dart';
import 'package:flutter/material.dart';

class PlaceTile extends StatelessWidget {
  const PlaceTile({
    super.key,
    required this.place,
  });

  final Place place;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // delete item
      },
      onTap: () => Navigator.pushNamed(context, '/details', arguments: place),
      child: Card(
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: ImageStack(
              place: place,
            ),
          )),
    );
  }
}
