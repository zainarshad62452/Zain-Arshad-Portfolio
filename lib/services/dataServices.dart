import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_portfolio/controllers/loading.dart';
import 'package:my_portfolio/models/Project.dart';
import 'package:my_portfolio/screens/snackbar.dart';

class DataServices {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  registerUser(
      {required String title,
      required String description,
      required String skillsUsed,
      required String mainImage,
      required List<String> images}) async {
    var x = Project(
        title: title,
        description: description,
        skillsUsed: skillsUsed,
        mainImage: mainImage,
        projectImages: images);
    try {
      final data = firestore.collection("Projects").doc();
      x.uid = data.id;
      data.set(x.toJson());
      loading(false);
    } catch (e) {
      loading(false);
      alertSnackbar("Can't register user");
    }
  }

  Stream<List<Project>>? streamAllProjects() {
    try {
      return firestore.collection("Projects").snapshots().map((event) {
        loading(false);
        List<Project> list = [];
        event.docs.forEach((element) {
          final admin = Project.fromJson(element.data());
          list.add(admin);
        });
        loading(false);
        return list;
      });
    } catch (e) {
      loading(false);
      return null;
    }
  }
}
