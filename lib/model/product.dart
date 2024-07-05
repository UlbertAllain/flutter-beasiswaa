class Product {
  final String id;
  final String name;
  final String category;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'],
      category: map['category'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'description': description,
    };
  }
}