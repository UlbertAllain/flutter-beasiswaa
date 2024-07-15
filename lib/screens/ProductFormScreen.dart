import 'package:flutter/material.dart';
import '../model/product.dart';
import '../services/ProductService.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  ProductFormScreen({this.product});

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _category;
  late String _description;
  int _selectedTemplateIndex = 0;
  final ProductService productService = ProductService();

  final List<String> imageTemplates = [
    'assets/template1.png',
    'assets/template2.png',
    'assets/template3.png',
    'assets/template4.png',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _name = widget.product!.name;
      _category = widget.product!.category;
      _description = widget.product!.description;
      _selectedTemplateIndex = widget.product!.imageTemplateIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: widget.product?.name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: widget.product?.category,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
                onSaved: (value) {
                  _category = value!;
                },
              ),
              TextFormField(
                initialValue: widget.product?.description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 20),
              Text('Select Template Image:'),
              SizedBox(height: 10),
              DropdownButton<int>(
                value: _selectedTemplateIndex,
                items: List.generate(
                  imageTemplates.length,
                  (index) => DropdownMenuItem<int>(
                    value: index,
                    child: Text('Template ${index + 1}'),
                  ),
                ),
                onChanged: (index) {
                  setState(() {
                    _selectedTemplateIndex = index!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final product = Product(
                      id: widget.product?.id ?? '',
                      name: _name,
                      category: _category,
                      description: _description,
                      imageTemplateIndex: _selectedTemplateIndex,
                    );

                    if (widget.product == null) {
                      productService.addProduct(product);
                    } else {
                      productService.updateProduct(product);
                    }

                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.product == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
