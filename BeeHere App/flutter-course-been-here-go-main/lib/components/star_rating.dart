import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = List.generate(5, (index) {
      if (index < rating) {
        return const Icon(
          Icons.star,
          color: Colors.amber,
        );
      } else {
        return const Icon(
          Icons.star_border,
          color: Colors.grey,
        );
      }
    });
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}
