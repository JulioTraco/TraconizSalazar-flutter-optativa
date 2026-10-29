import 'package:flutter/material.dart';
import '../carts/CartsService.dart';
import '../carts/Carrito.dart';

class CartsScreen extends StatefulWidget {
  final CartsService cartsService;

  const CartsScreen({super.key, required this.cartsService});

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  late Future<List<Carrito>> _cartsFuture;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _cartsFuture = widget.cartsService.getCarts();
  }

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carritos de compra')),
      body: FutureBuilder<List<Carrito>>(
        future: _cartsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final carritos = snapshot.data ?? [];
          return ListView.separated(
            itemCount: carritos.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final carrito = carritos[index];
              return ListTile(
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Colors.orange,
                  size: 40,
                ),
                title: Text(
                  'Cliente - ${carrito.userId}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: const Text(
                  'Click para ver detalles',
                  style: TextStyle(color: Colors.grey),
                ),
                onTap: () {},
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