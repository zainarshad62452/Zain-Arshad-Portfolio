import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_portfolio/models/Project.dart';

class EditProjectScreen extends StatefulWidget {
  final Project project;
  final String projectId;

  EditProjectScreen({required this.project, required this.projectId});

  @override
  _EditProjectScreenState createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _skillsUsedController;
  late TextEditingController _projectUrlController;
  late TextEditingController _sourceCodeController;
  late String _mainImageUrl;
  late List<String> _projectImageUrls;
  File? _mainImage;
  List<File> _projectImages = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.project.title);
    _descriptionController = TextEditingController(text: widget.project.description);
    _skillsUsedController = TextEditingController(text: widget.project.skillsUsed);
    _projectUrlController = TextEditingController(text: widget.project.projectUrl);
    _sourceCodeController = TextEditingController(text: widget.project.sourceCodeUrl);
    _mainImageUrl = widget.project.mainImage!;
    _projectImageUrls = widget.project.projectImages!;
  }

  Future<void> _pickMainImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _mainImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickProjectImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _projectImages = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      });
    }
  }

  Future<String> _uploadFile(File file, String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Upload new images if any
      if (_mainImage != null) {
        _mainImageUrl = await _uploadFile(_mainImage!, 'main_images/${DateTime.now().toString()}');
      }
      for (var image in _projectImages) {
        String imageUrl = await _uploadFile(image, 'project_images/${DateTime.now().toString()}');
        _projectImageUrls.add(imageUrl);
      }
      // Update project in Firestore
      Project updatedProject = Project(
        title: _titleController.text,
        description: _descriptionController.text,
        skillsUsed: _skillsUsedController.text,
        uid: widget.projectId,
        mainImage: _mainImageUrl,
        projectImages: _projectImageUrls,
        projectUrl: _projectUrlController.text,
        sourceCodeUrl: _sourceCodeController.text
      );
      await FirebaseFirestore.instance.collection('Projects').doc(widget.projectId).update(updatedProject.toJson());
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _skillsUsedController.dispose();
    _projectUrlController.dispose();
    _skillsUsedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Project')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Enter a description' : null,
              ),
              TextFormField(
                controller: _projectUrlController,
                decoration: InputDecoration(labelText: 'Project Url'),
              ),
              TextFormField(
                controller: _sourceCodeController,
                decoration: InputDecoration(labelText: 'Source Code'),
              ),
              TextFormField(
                controller: _skillsUsedController,
                decoration: InputDecoration(labelText: 'Skills Used'),
              ),
              SizedBox(height: 10),
              TextButton(
                child: Text('Pick Main Image'),
                onPressed: _pickMainImage,
              ),
              if (_mainImage != null) Image.file(_mainImage!),
              TextButton(
                child: Text('Pick Project Images'),
                onPressed: _pickProjectImages,
              ),
              Wrap(
                spacing: 8.0,
                children: _projectImages.map((image) => Image.file(image, width: 100, height: 100)).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Update'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
