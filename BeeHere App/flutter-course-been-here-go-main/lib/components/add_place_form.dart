import 'package:been_here_go/models/place.dart';
import 'package:been_here_go/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPlaceFrom extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String currentAddress;

  final XFile? imageFile;

  const AddPlaceFrom({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.currentAddress,
    this.imageFile,
  });

  @override
  State<AddPlaceFrom> createState() => _AddPlaceFromState();
}

class _AddPlaceFromState extends State<AddPlaceFrom> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _thoughtsController = TextEditingController();
  double _rating = 1;
  bool isSaving = false;

  void _savePlace(String currentUserId) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSaving = true;
      });
      String? imageUrl;
      //save the place
      if (widget.imageFile != null) {
        try {
          // save to storage
          imageUrl = await Provider.of<AuthProvider>(context, listen: false)
              .uploadImageToFirebase(widget.imageFile!);
        } catch (e) {
          print('$e');
        }
      }

      // 3. Instantiate our place object to which we pass the image url
      final newPlace = Place(
          userId: currentUserId,
          name: _nameController.text,
          description: _descriptionController.text,
          thoughts: _thoughtsController.text,
          currentAddress: widget.currentAddress,
          latitude: widget.latitude,
          longitude: widget.longitude,
          rating: _rating,
          imageUrl: imageUrl);

      // Save to firestore
      CollectionReference placesRef =
          FirebaseFirestore.instance.collection('places');

      placesRef.add(newPlace.toJson()).then((value) {
        // get the docid and update theplace with the doc
        var docId = value.id;
        placesRef.doc(docId).update({'docId': docId});

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Place Saved!'),
          duration: Duration(seconds: 2),
        ));
      }).whenComplete(() {
        setState(() {
          isSaving = false;
        });
        clearText();

        // navigate to places screen.
        Navigator.of(context).pushNamed('/places');
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _thoughtsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String currentUser =
        Provider.of<AuthProvider>(context, listen: false).user!.uid;
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Place Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _thoughtsController,
                  decoration: const InputDecoration(
                    labelText: 'Thoughts',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your thoughts';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Slider(
                    value: _rating,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: 'Rating: $_rating',
                    onChanged: (double value) {
                      setState(() {
                        _rating = value;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                if (isSaving)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  ElevatedButton(
                      onPressed: () => _savePlace(currentUser),
                      child: const Text('Save Place'))
              ],
            ),
          ),
        ));
  }

  void clearText() {
    _nameController.clear();
    _descriptionController.clear();
    _thoughtsController.clear();
  }
}
