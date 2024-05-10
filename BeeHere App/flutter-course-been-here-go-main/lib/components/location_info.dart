import 'package:flutter/material.dart';

class LocationInfo extends StatelessWidget {
  const LocationInfo({
    super.key,
    required String address,
  }) : _address = address;

  final String _address;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on,
          color: Theme.of(context).colorScheme.secondary,
        ),
        Text(
          _address,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}