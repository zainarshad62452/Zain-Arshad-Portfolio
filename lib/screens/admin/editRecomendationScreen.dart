import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:my_portfolio/models/Recommendation.dart';

class RecommendationEditScreen extends StatefulWidget {
  final Recommendation recommendation;
  final String docId;

  RecommendationEditScreen({required this.recommendation, required this.docId});

  @override
  _RecommendationEditScreenState createState() => _RecommendationEditScreenState();
}

class _RecommendationEditScreenState extends State<RecommendationEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController sourceController;
  late TextEditingController textController;
  File? _image;
  final picker = ImagePicker();
  bool _imageChanged = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.recommendation.name);
    sourceController = TextEditingController(text: widget.recommendation.source);
    textController = TextEditingController(text: widget.recommendation.text);
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageChanged = true;
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _updateRecommendation() async {
    if (_formKey.currentState!.validate()) {
      String? imageUrl = widget.recommendation.image;
      if (_imageChanged && _image != null) {
        // Upload new image to Firebase Storage
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef = FirebaseStorage.instance.ref().child('recommendations').child(fileName);
        UploadTask uploadTask = storageRef.putFile(_image!);
        TaskSnapshot taskSnapshot = await uploadTask;
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }

      // Update data in Firestore
      Recommendation updatedRecommendation = Recommendation(
        name: nameController.text,
        source: sourceController.text,
        text: textController.text,
        image: imageUrl,
      );
      FirebaseFirestore.instance.collection('recommendations').doc(widget.docId).update(updatedRecommendation.toJson());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Recommendation Updated!')));
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
        title: Text('Edit Recommendation'),
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
              _image == null && widget.recommendation.image != null
                  ? Image.network(widget.recommendation.image!)
                  : _image != null
                      ? Image.file(_image!)
                      : Text('No Image'),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateRecommendation,
                child: Text('Update Recommendation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
