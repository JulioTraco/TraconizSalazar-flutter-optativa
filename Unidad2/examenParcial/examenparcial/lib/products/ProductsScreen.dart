import 'package:flutter/material.dart';
import '../products/Product.dart';
import '../products/ProductsService.dart';
import '../product_by_id/ProductByIdService.dart';
import '../product_by_id/ProductByIdScreen.dart';
import '../carts/CartsScreen.dart';
import '../carts/CartsService.dart';

class ProductsScreen extends StatefulWidget {
  final ProductsService productsService;
  final ProductByIdService productByIdService;
  final CartsService cartsService;

  const ProductsScreen({
    super.key,
    required this.productsService,
    required this.productByIdService,
    required this.cartsService,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Product>> _productsFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _productsFuture = widget.productsService.getProducts();
  }

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CartsScreen(cartsService: widget.cartsService),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuarios')),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final products = snapshot.data ?? [];
          return ListView.separated(
            itemCount: products.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: Image.network(
                  product.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                ),
                title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text('${product.category} - \$${product.price}',
                    style: const TextStyle(color: Colors.grey)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductByIdScreen(
                        productByIdService: widget.productByIdService,
                        initialId: product.id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: const Color(0xFF1A237E),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Carritos'),
        ],
      ),
    );
  }
}