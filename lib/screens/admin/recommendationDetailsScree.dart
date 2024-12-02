import 'package:flutter/material.dart';
import 'package:my_portfolio/models/Recommendation.dart';
import 'package:my_portfolio/screens/admin/editRecomendationScreen.dart';

class RecommendationDetailScreen extends StatelessWidget {
  final Recommendation recommendation;
  final String docId;

  RecommendationDetailScreen({required this.recommendation, required this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendation Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${recommendation.name ?? 'No Name'}'),
            Text('Source: ${recommendation.source ?? 'No Source'}'),
            Text('Text: ${recommendation.text ?? 'No Text'}'),
            recommendation.image != null
                ? Image.network(recommendation.image!)
                : Text('No Image'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecommendationEditScreen(
                      recommendation: recommendation,
                      docId: docId,
                    ),
                  ),
                );
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
