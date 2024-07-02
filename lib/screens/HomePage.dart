import 'package:flutter/material.dart';
import 'package:uts_project/screens/Login_page.dart';
import 'package:uts_project/screens/ScholarshipDetailPage.dart';
import '../model/product.dart';
import '../../services/ProductService.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final ProductService productService = ProductService();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);
    _fetchProducts();
  }

  void _fetchProducts() async {
    final products = await productService.getProducts().first;
    setState(() {
      _products = products;
      _filteredProducts = products;
    });
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((product) {
        return product.name.toLowerCase().contains(query) ||
            product.category.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beasiswaku'),
      ),
      body: Column(
        children: [
          if (_currentIndex == 0) 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          Expanded(child: _getSelectedWidget()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Admin',
          ),
        ],
      ),
    );
  }

  Widget buildProductList() {
  return ListView.builder(
    itemCount: _filteredProducts.length,
    itemBuilder: (context, index) {
      final product = _filteredProducts[index];

      return ListTile(
        title: Text(product.name),
        subtitle: Text(product.category),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScholarshipDetailPage(scholarship: product),
            ),
          );
        },
      );
    },
  );
}


  Widget _getSelectedWidget() {
    switch (_currentIndex) {
      case 0:
        return buildProductList();
      case 1:
        return LoginPage();
      default:
        return buildProductList();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
