import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/models/Project.dart';
import 'package:my_portfolio/screens/admin/eidtProject.dart';
import 'package:my_portfolio/screens/home/components/project_details_screen.dart';

class ProjectsListScreen extends StatefulWidget {
  @override
  _ProjectsListScreenState createState() => _ProjectsListScreenState();
}

class _ProjectsListScreenState extends State<ProjectsListScreen> {
  Future<List<Project>> _fetchProjects() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Projects').get();
    return snapshot.docs.map((doc) => Project.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  void _deleteProject(String projectId) async {
    await FirebaseFirestore.instance.collection('Projects').doc(projectId).delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projects')),
      body: FutureBuilder<List<Project>>(
        future: _fetchProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching projects'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No projects found'));
          } else {
            List<Project> projects = snapshot.data!;
            return ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                Project project = projects[index];
                return ListTile(
                  title: Text(project.title ?? 'No Title'),
                  subtitle: Text(project.description ?? 'No Description'),
                  leading: project.mainImage != null
                      ? Image.network(
                          project.mainImage!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey,
                        ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectDetailsScreen(project: project),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProjectScreen(project: project, projectId: project.uid.toString()),
                            ),
                          ).then((_) => setState(() {}));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteProject(project.uid!),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

// class ProjectDetailsScreen extends StatelessWidget {
//   final Project project;

//   const ProjectDetailsScreen({Key? key, required this.project}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Project Details'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: ListView(
//               children: [
//                 if (project.mainImage != null)
//                   Image.network(
//                     project.mainImage!,
//                     width: MediaQuery.of(context).size.width,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 SizedBox(height: 16),
//                 Text(
//                   project.title ?? 'No Title',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   project.description ?? 'No Description',
//                   style: TextStyle(fontSize: 16),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 16),
//                 if (project.projectImages != null && project.projectImages!.isNotEmpty)
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 8,
//                     children: project.projectImages!
//                         .map(
//                           (imageUrl) => GestureDetector(
//                             onTap: () {
//                               // Handle onTap event for showing full image
//                               // You can navigate to a new screen to display the full image
//                               print('Show full image: $imageUrl');
//                             },
//                             child: Image.network(
//                               imageUrl,
//                               width: 100,
//                               height: 100,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         )
//                         .toList(),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
