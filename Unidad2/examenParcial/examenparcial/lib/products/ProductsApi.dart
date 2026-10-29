import '../base/AbstractApiHandler.dart';

class ProductsApi extends AbstractApiHandler<void, String> {
  ProductsApi({required super.httpClient});

  static const String _url = 'https://fakestoreapi.com/products';

  @override
  Future<String> doExecute(void input) {
    return webClientGet(_url);
  }
}