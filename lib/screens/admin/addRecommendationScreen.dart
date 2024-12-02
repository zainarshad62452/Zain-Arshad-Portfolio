import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:my_portfolio/models/Recommendation.dart';

class AddRecommendationScreen extends StatefulWidget {
  @override
  _AddRecommendationScreenState createState() => _AddRecommendationScreenState();
}

class _AddRecommendationScreenState extends State<AddRecommendationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _addRecommendation() async {
    if (_formKey.currentState!.validate()) {
      String? imageUrl;
      if (_image != null) {
        // Upload new image to Firebase Storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef = FirebaseStorage.instance.ref().child('recommendations').child(fileName);
        UploadTask uploadTask = storageRef.putFile(_image!);
        TaskSnapshot taskSnapshot = await uploadTask;
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }

      // Save data to Firestore
      Recommendation newRecommendation = Recommendation(
        name: nameController.text,
        source: sourceController.text,
        text: textController.text,
        image: imageUrl,
      );
      FirebaseFirestore.instance.collection('recommendations').add(newRecommendation.toJson());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Recommendation Added!')));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    sourceController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recommendation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: sourceController,
                decoration: InputDecoration(labelText: 'Source'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a source';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Text'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _image != null
                  ? Image.file(_image!)
                  : Text('No Image'),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addRecommendation,
                child: Text('Add Recommendation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
