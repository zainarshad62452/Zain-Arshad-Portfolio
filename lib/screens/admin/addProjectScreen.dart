// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:my_portfolio/models/Project.dart';
// import 'package:provider/provider.dart';

// class ProjectFormScreen extends StatefulWidget {
//   @override
//   _ProjectFormScreenState createState() => _ProjectFormScreenState();
// }

// class _ProjectFormScreenState extends State<ProjectFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _picker = ImagePicker();

//   String? _title, _description, _skillsUsed, _uid, _mainImageUrl;
//   List<File> _projectImages = [];
//   File? _mainImage;

//   Future<void> _pickMainImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _mainImage = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _pickProjectImages() async {
//     final pickedFiles = await _picker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         _projectImages =
//             pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
//       });
//     }
//   }

//   Future<String> _uploadFile(File file, String path) async {
//     final ref = FirebaseStorage.instance.ref().child(path);
//     await ref.putFile(file);
//     return await ref.getDownloadURL();
//   }

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (ctx) => AlertDialog(
//           content: Row(
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(width: 20),
//               Text('Submitting...'),
//             ],
//           ),
//         ),
//       );

//       try {
//         if (_mainImage != null) {
//           _mainImageUrl = await _uploadFile(
//               _mainImage!, 'main_images/${DateTime.now().toString()}');
//         }
//         List<String> projectImageUrls = [];
//         for (var image in _projectImages) {
//           String imageUrl = await _uploadFile(
//               image, 'project_images/${DateTime.now().toString()}');
//           projectImageUrls.add(imageUrl);
//         }

//         Project project = Project(
//           title: _title,
//           description: _description,
//           skillsUsed: _skillsUsed,
//           uid: _uid,
//           mainImage: _mainImageUrl,
//           projectImages: projectImageUrls,
//         );
//         print(project.toJson());
//         final data = FirebaseFirestore.instance.collection('Projects').doc();
//         project.uid = data.id;
//         await data.set(project.toJson());
//       } catch (error) {
//         print('Error: $error');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to submit project. Please try again.'),
//           ),
//         );
//       } finally {
//         Navigator.pop(context); // Remove the loading dialog
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Project')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Title'),
//                 onSaved: (value) => _title = value,
//                 onChanged: (value) => setState(() {
//                   _title = value;
//                 }),
//                 validator: (value) => value!.isEmpty ? 'Enter a title' : null,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Description'),
//                 onSaved: (value) => _description = value,
//                 onChanged: (value) => setState(() {
//                   _description = value;
//                 }),
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter a description' : null,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Skills Used'),
//                 onChanged: (value) => setState(() {
//                   _skillsUsed = value;
//                 }),
//                 onSaved: (value) => _skillsUsed = value,
//               ),
//               SizedBox(height: 10),
//               TextButton(
//                 child: Text('Pick Main Image'),
//                 onPressed: _pickMainImage,
//               ),
//               if (_mainImage != null) Image.file(_mainImage!),
//               TextButton(
//                 child: Text('Pick Project Images'),
//                 onPressed: _pickProjectImages,
//               ),
//               Wrap(
//                 spacing: 8.0,
//                 children: _projectImages
//                     .map((image) => Image.file(image, width: 100, height: 100))
//                     .toList(),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 child: Text('Submit'),
//                 onPressed: _submitForm,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_portfolio/models/Project.dart';

class ProjectFormScreen extends StatefulWidget {
  @override
  _ProjectFormScreenState createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends State<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _skillsUsedController;
  late TextEditingController _projectUrlController;
  late TextEditingController _sourceCodeController;
  String? _uid, _mainImageUrl;
  List<File> _projectImages = [];
  File? _mainImage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _skillsUsedController = TextEditingController();
    _projectUrlController = TextEditingController();
    _sourceCodeController = TextEditingController();
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
        _projectImages =
            pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Submitting...'),
            ],
          ),
        ),
      );

      try {
        if (_mainImage != null) {
          _mainImageUrl = await _uploadFile(
              _mainImage!, 'main_images/${DateTime.now().toString()}');
        }
        List<String> projectImageUrls = [];
        for (var image in _projectImages) {
          String imageUrl = await _uploadFile(
              image, 'project_images/${DateTime.now().toString()}');
          projectImageUrls.add(imageUrl);
        }

        Project project = Project(
          title: _titleController.text,
          description: _descriptionController.text,
          skillsUsed: _skillsUsedController.text,
          uid: _uid,
          mainImage: _mainImageUrl ?? "",
          projectImages: projectImageUrls,
          projectUrl: _projectUrlController.text,
          sourceCodeUrl: _sourceCodeController.text,
        );
        final data = FirebaseFirestore.instance.collection('Projects').doc();
        project.uid = data.id;
        await data.set(project.toJson());
      } catch (error) {
        print('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit project. Please try again.'),
          ),
        );
      } finally {
        Navigator.pop(context); // Remove the loading dialog
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Project')),
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
                validator: (value) =>
                    value!.isEmpty ? 'Enter a description' : null,
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
                children: _projectImages
                    .map((image) => Image.file(image, width: 100, height: 100))
                    .toList(),
              ),
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
