import 'dart:convert';
import '../base/AbstractServiceHandler.dart';
import '../products/Product.dart';
import 'ProductByIdApi.dart';

class ProductByIdService extends AbstractServiceHandler<int, Product> {
  final ProductByIdApi productByIdApi;

  ProductByIdService({required this.productByIdApi});

  Future<Product> getProductById(int id) {
    return execute(id);
  }

  @override
  Future<Product> doExecute(int input) async {
    final body = await productByIdApi.execute(input);
    final json = jsonDecode(body) as Map<String, dynamic>;
    return Product.fromJson(json);
  }
}