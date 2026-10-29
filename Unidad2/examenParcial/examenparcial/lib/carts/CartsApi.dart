import '../base/AbstractApiHandler.dart';

class CartsApi extends AbstractApiHandler<void, String> {
  CartsApi({required super.httpClient});

  static const String _url = 'https://fakestoreapi.com/carts';

  @override
  Future<String> doExecute(void input) {
    return webClientGet(_url);
  }
}