import 'package:flutter/material.dart';
import '../screens/Login_page.dart';
import '../screens/ScholarshipDetailPage.dart';
import '../widgets/constants.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_currentIndex == 0)
            Container(
              color: Color.fromARGB(0, 255, 255,
                  255), 
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(
                      115, 149, 230, 231), 
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none, 
                  ),
                  prefixIcon: Icon(Icons.search,
                      color: Colors
                          .grey[600]), 
                  suffixIcon: IconButton(
                    
                    icon: Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  ),
                ),
              ),
            ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/background.jpeg'), // Ganti dengan path gambar yang sesuai
                        fit: BoxFit
                            .cover, // Sesuaikan cara gambar diatur dalam kontainer
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                   
                    ),
                  ),
                ),
                Positioned.fill(
                  child: _getSelectedWidget(),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue,
        selectedItemColor:
            Colors.white, 
        unselectedItemColor: Colors
            .blue[200], 
        elevation: 8.0, 
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
        final int templateIndex =
            product.imageTemplateIndex % imageTemplates.length;

        return Container(
          height: 120,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(imageTemplates[templateIndex]),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment(1.00, 0.00),
                    end: Alignment(-1, 0),
                    colors: [
                      Color(0xFF398AB9),
                      Color(0x7B1B4359),
                      Colors.black.withOpacity(0)
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: ListTile(
                    title: Stack(
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 20,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Color.fromARGB(223, 253, 253, 253),
                          ),
                        ),
                        Text(
                          product.name,
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20),
                        ),
                      ],
                    ),
                    subtitle: Stack(
                      children: [
                        Text(
                          product.category,
                          style: TextStyle(
                            fontSize: 14,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        Text(
                          product.category,
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 14),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ScholarshipDetailPage(scholarship: product),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
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
