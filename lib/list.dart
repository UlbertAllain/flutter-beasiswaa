// import 'package:flutter/material.dart';

// import '../product.dart';
// import '../services/ProductService.dart';
// import 'ProductFormScreen.dart';


// class list extends StatelessWidget {
//   final ProductService productService = ProductService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Beranda'),
//       ),
//       body: StreamBuilder<List<Product>>(
        
//         stream: productService.getProducts(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           final products = snapshot.data!;

//           return ListView.builder(
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];

//               return ListTile(
//                 title: Text(product.name),
//                 subtitle: Text(product.category),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,

//                 ),
//               );
//             },
//           );
//         },
//       ),
      
//     );
//   }
// }
