import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/models/Recommendation.dart';
import 'package:my_portfolio/screens/admin/addRecommendationScreen.dart';
import 'package:my_portfolio/screens/admin/recommendationDetailsScree.dart'; 

class RecommendationsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('recommendations').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              Recommendation recommendation = Recommendation.fromJson(document.data() as Map<String, dynamic>);
              return ListTile(
                title: Text(recommendation.name ?? 'No Name'),
                subtitle: Text(recommendation.source ?? 'No Source'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecommendationDetailScreen(
                        recommendation: recommendation,
                        docId: document.id,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRecommendationScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
