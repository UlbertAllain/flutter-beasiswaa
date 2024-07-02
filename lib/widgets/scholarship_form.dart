// import 'package:flutter/material.dart';
// import '../model/scholarship.dart';

// class ScholarshipForm extends StatefulWidget {
//   final Scholarship? scholarship;
//   final Function(Scholarship) onSave;

//   ScholarshipForm({this.scholarship, required this.onSave});

//   @override
//   _ScholarshipFormState createState() => _ScholarshipFormState();
// }

// class _ScholarshipFormState extends State<ScholarshipForm> {
//   final _formKey = GlobalKey<FormState>();
//   late String _name;
//   late String _description;

//   @override
//   void initState() {
//     super.initState();
//     _name = widget.scholarship?.name ?? '';
//     _description = widget.scholarship?.description ?? '';
//   }

//   void _saveForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       final newScholarship = Scholarship(
//         id: widget.scholarship?.id ?? '',
//         name: _name,
//         description: _description, amount: '',
//       );
//       widget.onSave(newScholarship);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             initialValue: _name,
//             decoration: InputDecoration(labelText: 'Name'),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter a name';
//               }
//               return null;
//             },
//             onSaved: (value) {
//               _name = value!;
//             },
//           ),flutte
//           TextFormField(
//             initialValue: _description,
//             decoration: InputDecoration(labelText: 'Description'),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter a description';
//               }
//               return null;
//             },
//             onSaved: (value) {
//               _description = value!;
//             },
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: _saveForm,
//             child: Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }
// }
