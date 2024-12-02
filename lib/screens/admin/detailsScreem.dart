import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_portfolio/models/user.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  DetailsModel? _details;
  File? _profileImage, _bannerImage, _cvFile;

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

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('details')
        .doc('AllDetails')
        .get();
    if (snapshot.exists) {
      setState(() {
        _details =
            DetailsModel.fromJson(snapshot.data() as Map<String, dynamic>);

        _nameController = TextEditingController(text: _details?.myName);
        _titleController = TextEditingController(text: _details?.title);
        _residenceController = TextEditingController(text: _details?.residence);
        _cityController = TextEditingController(text: _details?.city);
        _ageController = TextEditingController(text: _details?.age);
        _cvLinkController = TextEditingController(text: _details?.cvLink);
        _linkedInController = TextEditingController(text: _details?.linkedIn);
        _githubController = TextEditingController(text: _details?.github);
        _fiverrController = TextEditingController(text: _details?.fiverr);
        _upworkController = TextEditingController(text: _details?.upwork);
        _quoteController = TextEditingController(text: _details?.qoute);
        _subHeadlinesController =
            TextEditingController(text: _details?.subHeadlines);
        _skillsController =
            TextEditingController(text: _details?.skills?.join(', '));
        _skillsPercentageController =
            TextEditingController(text: _details?.skillsPercentage?.join(', '));
        _languagesController =
            TextEditingController(text: _details?.languages?.join(', '));
        _languagesPercentageController = TextEditingController(
            text: _details?.languagesPercentage?.join(', '));
        _knowledgesController =
            TextEditingController(text: _details?.knowledges?.join(', '));
        _headlinesController =
            TextEditingController(text: _details?.headlines?.join(', '));
      });
    }
  }

  Future<void> _pickImage(bool isProfileImage) async {
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

  Future<void> _pickCVFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        _cvFile = File(result.files.single.path!);
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
      if (_profileImage != null) {
        _details!.profileImage = await _uploadFile(
            _profileImage!, 'profile_images/${DateTime.now().toString()}');
      }
      if (_bannerImage != null) {
        _details!.bannerImage = await _uploadFile(
            _bannerImage!, 'banner_images/${DateTime.now().toString()}');
      }
      if (_cvFile != null) {
        _details!.cvLink = await _uploadFile(
            _cvFile!, 'cv_files/${DateTime.now().toString()}');
      }
      _details!.myName = _nameController.text;
      _details!.title = _titleController.text;
      _details!.residence = _residenceController.text;
      _details!.city = _cityController.text;
      _details!.age = _ageController.text;
      // _details!.cvLink = _cvLinkController.text;
      _details!.linkedIn = _linkedInController.text;
      _details!.github = _githubController.text;
      _details!.fiverr = _fiverrController.text;
      _details!.upwork = _upworkController.text;
      _details!.qoute = _quoteController.text;
      _details!.subHeadlines = _subHeadlinesController.text;
      _details!.skills =
          _skillsController.text.split(',').map((s) => s.trim()).toList();
      _details!.skillsPercentage = _skillsPercentageController.text
          .split(',')
          .map((s) => double.parse(s.trim()))
          .toList();
      _details!.languages =
          _languagesController.text.split(',').map((s) => s.trim()).toList();
      _details!.languagesPercentage = _languagesPercentageController.text
          .split(',')
          .map((s) => double.parse(s.trim()))
          .toList();
      _details!.knowledges =
          _knowledgesController.text.split(',').map((s) => s.trim()).toList();
      _details!.headlines =
          _headlinesController.text.split(',').map((s) => s.trim()).toList();

      await FirebaseFirestore.instance
          .collection('details')
          .doc('AllDetails')
          .set(_details!.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Details updated successfully')));
    }
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_details == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Your Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextFormField(
                controller: _residenceController,
                decoration: InputDecoration(labelText: 'Residence'),
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextFormField(
                controller: _cvLinkController,
                decoration: InputDecoration(labelText: 'CV Link'),
              ),
              if (_details!.cvLink != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text('Current CV: ${_details!.cvLink!}'),
                ),
              TextButton(
                child: Text('Update CV (PDF)'),
                onPressed: _pickCVFile,
              ),
              if (_cvFile != null)
                Text('Selected file: ${_cvFile!.path.split('/').last}'),
              TextFormField(
                controller: _linkedInController,
                decoration: InputDecoration(labelText: 'LinkedIn'),
              ),
              TextFormField(
                controller: _githubController,
                decoration: InputDecoration(labelText: 'GitHub'),
              ),
              TextFormField(
                controller: _fiverrController,
                decoration: InputDecoration(labelText: 'Fiverr'),
              ),
              TextFormField(
                controller: _upworkController,
                decoration: InputDecoration(labelText: 'Upwork'),
              ),
              TextFormField(
                controller: _quoteController,
                decoration: InputDecoration(labelText: 'Quote'),
              ),
              TextFormField(
                controller: _subHeadlinesController,
                decoration: InputDecoration(labelText: 'Sub Headlines'),
              ),
              TextFormField(
                controller: _skillsController,
                decoration:
                    InputDecoration(labelText: 'Skills (comma separated)'),
              ),
              TextFormField(
                controller: _skillsPercentageController,
                decoration: InputDecoration(
                    labelText: 'Skills Percentage (comma separated)'),
              ),
              TextFormField(
                controller: _languagesController,
                decoration:
                    InputDecoration(labelText: 'Languages (comma separated)'),
              ),
              TextFormField(
                controller: _languagesPercentageController,
                decoration: InputDecoration(
                    labelText: 'Languages Percentage (comma separated)'),
              ),
              TextFormField(
                controller: _knowledgesController,
                decoration:
                    InputDecoration(labelText: 'Knowledges (comma separated)'),
              ),
              TextFormField(
                controller: _headlinesController,
                decoration:
                    InputDecoration(labelText: 'Headlines (comma separated)'),
              ),
              SizedBox(height: 20),
              TextButton(
                child: Text('Pick Profile Image'),
                onPressed: () => _pickImage(true),
              ),
              if (_profileImage != null)
                Image.file(_profileImage!, height: 100, width: 100),
              if (_details!.profileImage != null && _profileImage == null)
                Image.network(_details!.profileImage!, height: 100, width: 100),
              SizedBox(height: 20),
              TextButton(
                child: Text('Pick Banner Image'),
                onPressed: () => _pickImage(false),
              ),
              if (_bannerImage != null)
                Image.file(_bannerImage!, height: 100, width: 100),
              if (_details!.bannerImage != null && _bannerImage == null)
                Image.network(_details!.bannerImage!, height: 100, width: 100),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
