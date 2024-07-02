import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product.dart';

class ProductService {
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('products');

  Future<void> addProduct(Product product) {
    return productCollection.add(product.toMap());
  }

  Future<void> updateProduct(Product product) {
    return productCollection.doc(product.id).update(product.toMap());
  }

  Future<void> deleteProduct(String id) {
    return productCollection.doc(id).delete();
  }

  Stream<List<Product>> getProducts() {
    return productCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
