import 'package:flutter/material.dart';

import '../model/product.dart';
import '../services/ProductService.dart';
import 'ProductFormScreen.dart';


class ProductListScreen extends StatelessWidget {
  final ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: StreamBuilder<List<Product>>(
        stream: productService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.category),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Implement edit functionality
                          Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductFormScreen(product: product),
                        ));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        productService.deleteProduct(product.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Implement add functionality
           Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductFormScreen(),
          ));
        },
      ),
    );
  }
}
