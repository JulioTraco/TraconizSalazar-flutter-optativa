import 'package:flutter/material.dart';
import '../models/carrito.dart';

class CarritoItem extends StatelessWidget {
  final Carrito carrito;

  const CarritoItem({super.key, required this.carrito});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        'assets/carrito.png',
        width: 50,
        height: 50,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.shopping_cart,
          color: Colors.orange,
          size: 40,
        ),
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
  }
}