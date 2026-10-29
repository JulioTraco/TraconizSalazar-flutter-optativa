class ProductoCarrito {
  final int productId;
  final int quantity;

  ProductoCarrito({required this.productId, required this.quantity});

  factory ProductoCarrito.fromJson(Map<String, dynamic> json) {
    return ProductoCarrito(
      productId: json['productId'] ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }
}

class Carrito {
  final int id;
  final int userId;
  final List<ProductoCarrito> products;

  Carrito({required this.id, required this.userId, required this.products});

  factory Carrito.fromJson(Map<String, dynamic> json) {
    return Carrito(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      products: (json['products'] as List)
          .map((p) => ProductoCarrito.fromJson(p))
          .toList(),
    );
  }
}