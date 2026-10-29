import 'package:flutter/material.dart';
import '../models/producto.dart';
import '../screens/detalle_producto_screen.dart';

class ProductoItem extends StatelessWidget {
  final Producto producto;

  const ProductoItem({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        producto.image,
        width: 50,
        height: 50,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported),
      ),
      title: Text(
        producto.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${producto.category} - \$${producto.price}',
        style: const TextStyle(color: Colors.grey),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalleProductoScreen(producto: producto),
          ),
        );
      },
    );
  }
}