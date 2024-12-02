import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_portfolio/models/user.dart';

class DetailsFormScreen extends StatefulWidget {
  @override
  _DetailsFormScreenState createState() => _DetailsFormScreenState();
}

class _DetailsFormScreenState extends State<DetailsFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late TextEditingController _nameController;
  late TextEditingController _titleController;
  late TextEditingController _residenceController;
  late TextEditingController _cityController;
  late TextEditingController _ageController;
  late TextEditingController _cvLinkController;
  late TextEditingController _linkedInController;
  late TextEditingController _githubController;
  late TextEditingController _fiverrController;
  late TextEditingController _upworkController;
  late TextEditingController _quoteController;
  late TextEditingController _subHeadlinesController;
  late TextEditingController _skillsController;
  late TextEditingController _skillsPercentageController;
  late TextEditingController _languagesController;
  late TextEditingController _languagesPercentageController;
  late TextEditingController _knowledgesController;
  late TextEditingController _headlinesController;
  late TextEditingController _tagController;

  File? _profileImage, _bannerImage, _cvFile;
  String? _profileImageUrl, _bannerImageUrl, _cvFileUrl;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _titleController = TextEditingController();
    _residenceController = TextEditingController();
    _cityController = TextEditingController();
    _ageController = TextEditingController();
    _cvLinkController = TextEditingController();
    _linkedInController = TextEditingController();
    _githubController = TextEditingController();
    _fiverrController = TextEditingController();
    _upworkController = TextEditingController();
    _quoteController = TextEditingController();
    _subHeadlinesController = TextEditingController();
    _skillsController = TextEditingController();
    _skillsPercentageController = TextEditingController();
    _languagesController = TextEditingController();
    _languagesPercentageController = TextEditingController();
    _knowledgesController = TextEditingController();
    _headlinesController = TextEditingController();
    _tagController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _residenceController.dispose();
    _cityController.dispose();
    _ageController.dispose();
    _cvLinkController.dispose();
    _linkedInController.dispose();
    _githubController.dispose();
    _fiverrController.dispose();
    _upworkController.dispose();
    _quoteController.dispose();
    _subHeadlinesController.dispose();
    _skillsController.dispose();
    _skillsPercentageController.dispose();
    _languagesController.dispose();
    _languagesPercentageController.dispose();
    _knowledgesController.dispose();
    _headlinesController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(bool isProfileImage, bool isPdf) async {
    if (isPdf) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null) {
        setState(() {
          _cvFile = File(result.files.single.path!);
        });
      }
    } else {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          if (isProfileImage) {
            _profileImage = File(pickedFile.path);
          } else {
            _bannerImage = File(pickedFile.path);
          }
        });
      }
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Submitting...'),
            ],
          ),
        ),
      );
      if (_profileImage != null) {
        _profileImageUrl = await _uploadFile(
            _profileImage!, 'profile_images/${DateTime.now().toString()}');
      }
      if (_bannerImage != null) {
        _bannerImageUrl = await _uploadFile(
            _bannerImage!, 'banner_images/${DateTime.now().toString()}');
      }
      if (_cvFile != null) {
        _cvFileUrl = await _uploadFile(
            _cvFile!, 'cv_files/${DateTime.now().toString()}');
      }
      DetailsModel details = DetailsModel(
        myName: _nameController.text,
        title: _titleController.text,
        residence: _residenceController.text,
        city: _cityController.text,
        age: _ageController.text,
        skills: _skillsController.text.split(',').map((s) => s.trim()).toList(),
        skillsPercentage: _skillsPercentageController.text
            .split(',')
            .map((s) => double.parse(s.trim()))
            .toList(),
        languages:
            _languagesController.text.split(',').map((s) => s.trim()).toList(),
        languagesPercentage: _languagesPercentageController.text
            .split(',')
            .map((s) => double.parse(s.trim()))
            .toList(),
        knowledges:
            _knowledgesController.text.split(',').map((s) => s.trim()).toList(),
        cvLink: _cvFileUrl,
        linkedIn: _linkedInController.text,
        github: _githubController.text,
        fiverr: _fiverrController.text,
        upwork: _upworkController.text,
        qoute: _quoteController.text,
        headlines:
            _headlinesController.text.split(',').map((s) => s.trim()).toList(),
        profileImage: _profileImageUrl,
        bannerImage: _bannerImageUrl,
        subHeadlines: _subHeadlinesController.text,
        tag: _tagController.text,
      );
      await FirebaseFirestore.instance
          .collection('details')
          .doc("AllDetails")
          .set(details.toJson());
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Your Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                controller: _nameController,
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Residence'),
                controller: _residenceController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'City'),
                controller: _cityController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                controller: _ageController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tag'),
                controller: _tagController,
              ),
              // Add more
              TextFormField(
                decoration: InputDecoration(labelText: 'CV Link'),
                controller: _cvLinkController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'LinkedIn'),
                controller: _linkedInController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'GitHub'),
                controller: _githubController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fiverr'),
                controller: _fiverrController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Upwork'),
                controller: _upworkController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quote'),
                controller: _quoteController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sub Headlines'),
                controller: _subHeadlinesController,
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Skills (comma separated)'),
                controller: _skillsController,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Skills Percentage (comma separated)'),
                controller: _skillsPercentageController,
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Languages (comma separated)'),
                controller: _languagesController,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Languages Percentage (comma separated)'),
                controller: _languagesPercentageController,
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Knowledges (comma separated)'),
                controller: _knowledgesController,
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Headlines (comma separated)'),
                controller: _headlinesController,
              ),
              SizedBox(height: 20),
              TextButton(
                child: Text('Pick Profile Image'),
                onPressed: () => _pickFile(true, false),
              ),
              if (_profileImage != null)
                Image.file(_profileImage!, height: 100, width: 100),
              SizedBox(height: 20),
              TextButton(
                child: Text('Pick Banner Image'),
                onPressed: () => _pickFile(false, false),
              ),
              if (_bannerImage != null)
                Image.file(_bannerImage!, height: 100, width: 100),
              SizedBox(height: 20),
              TextButton(
                child: Text('Pick CV (PDF)'),
                onPressed: () => _pickFile(false, true),
              ),
              if (_cvFile != null)
                Text('PDF Selected: ${_cvFile!.path.split('/').last}'),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
