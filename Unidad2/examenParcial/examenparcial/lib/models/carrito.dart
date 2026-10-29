class ProductoCarrito {
  final int productId;
  final int quantity;

  ProductoCarrito({
    required this.productId,
    required this.quantity,
  });

  factory ProductoCarrito.fromJson(Map<String, dynamic> json) {
    return ProductoCarrito(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}

class Carrito {
  final int id;
  final int userId;
  final List<ProductoCarrito> products;

  Carrito({
    required this.id,
    required this.userId,
    required this.products,
  });

  factory Carrito.fromJson(Map<String, dynamic> json) {
    return Carrito(
      id: json['id'],
      userId: json['userId'],
      products: (json['products'] as List)
          .map((p) => ProductoCarrito.fromJson(p))
          .toList(),
    );
  }
}