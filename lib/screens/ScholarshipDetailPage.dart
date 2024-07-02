import 'package:flutter/material.dart';
import '../model/product.dart';
import 'ApplyFormScreen.dart';

class ScholarshipDetailPage extends StatelessWidget {
  final Product scholarship;

  ScholarshipDetailPage({required this.scholarship});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(scholarship.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scholarship.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              scholarship.category,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 16),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApplyFormPage(scholarship: scholarship),
                    ),
                  );
                },
                child: Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
