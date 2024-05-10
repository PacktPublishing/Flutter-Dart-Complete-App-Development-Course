import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraButton extends StatefulWidget {
  // pass a callback function to the constructor for the image file
  final void Function(XFile image) onImageTaken;
  const CameraButton({
    super.key,
    required this.onImageTaken,
  });

  @override
  State<CameraButton> createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> {
  XFile? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final XFile? imageFile =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 450);

    if (imageFile == null) {
      return;
    }

    setState(() {
      _selectedImage = imageFile;
    });

    widget.onImageTaken(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        icon: const Icon(Icons.camera_alt_outlined),
        label: const Text('Take a Picture'));

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Image.file(
            File(_selectedImage!.path),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.4))),
      child: content,
    );
  }
}
