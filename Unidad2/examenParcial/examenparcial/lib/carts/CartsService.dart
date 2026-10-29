import 'dart:convert';
import '../base/AbstractServiceHandler.dart';
import 'Carrito.dart';
import 'CartsApi.dart';

class CartsService extends AbstractServiceHandler<void, List<Carrito>> {
  final CartsApi cartsApi;

  CartsService({required this.cartsApi});

  Future<List<Carrito>> getCarts() {
    return execute(null);
  }

  @override
  Future<List<Carrito>> doExecute(void input) async {
    final body = await cartsApi.execute(null);
    final List data = jsonDecode(body);
    return data.map((item) => Carrito.fromJson(item as Map<String, dynamic>)).toList();
  }
}