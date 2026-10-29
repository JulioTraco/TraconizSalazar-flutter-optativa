import 'package:examenparcial/base/CustomException.dart';
import 'package:examenparcial/base/Handler.dart';

abstract class AbstractServiceHandler<U, T> implements Handler<U, T> {
  @override
  Future<T> execute(U input) async {
    try {
      final T result = await doExecute(input);
      return result;
    } on CustomException {
      rethrow;
    } catch (e) {
      final className = runtimeType.toString();
      throw Exception('Error executing service=$className: $e');
    }
  }

  Future<T> doExecute(U input);
}