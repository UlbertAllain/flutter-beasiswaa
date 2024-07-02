import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product.dart';

class ApplyFormPage extends StatefulWidget {
  final Product scholarship;

  ApplyFormPage({required this.scholarship});

  @override
  _ApplyFormPageState createState() => _ApplyFormPageState();
}

class _ApplyFormPageState extends State<ApplyFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apply for ${widget.scholarship.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _schoolController,
                decoration: InputDecoration(labelText: 'School'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your school';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await FirebaseFirestore.instance.collection('applications').add({
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'school': _schoolController.text,
                      'scholarship': widget.scholarship.name,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Application submitted')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _schoolController.dispose();
    super.dispose();
  }
}
