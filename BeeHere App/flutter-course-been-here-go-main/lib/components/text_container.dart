import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String header;
  final String content;

  const TextContainer({
    super.key,
    required this.content,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$header:',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1.5, color: Theme.of(context).colorScheme.primary)),
          child: Text(content),
        ),
      ],
    );
  }
}
