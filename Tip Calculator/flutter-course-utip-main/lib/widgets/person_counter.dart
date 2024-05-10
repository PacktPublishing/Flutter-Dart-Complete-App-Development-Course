import 'package:flutter/material.dart';

class PersonCounter extends StatelessWidget {
  const PersonCounter({
    super.key,
    required this.theme,
    required int personCount,
    required this.onDecrement,
    required this.onIncrement,
  }) : _personCount = personCount;

  final ThemeData theme;
  final int _personCount;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Split',
          style: theme.textTheme.titleMedium,
        ),
        Row(
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: Icon(
                Icons.remove,
                color: theme.colorScheme.primary,
              ),
            ),
            Text(
              '$_personCount',
              style: theme.textTheme.titleMedium,
            ),
            IconButton(
              onPressed: onIncrement,
              icon: Icon(
                Icons.add,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
