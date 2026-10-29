import 'dart:convert';
import '../base/AbstractServiceHandler.dart';
import 'Product.dart';
import 'ProductsApi.dart';

class ProductsService extends AbstractServiceHandler<void, List<Product>> {
  final ProductsApi productsApi;

  ProductsService({required this.productsApi});

  Future<List<Product>> getProducts() {
    return execute(null);
  }

  @override
  Future<List<Product>> doExecute(void input) async {
    final body = await productsApi.execute(null);
    final List data = jsonDecode(body);
    return data.map((item) => Product.fromJson(item as Map<String, dynamic>)).toList();
  }
}