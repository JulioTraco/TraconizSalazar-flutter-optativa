import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:examenparcial/base/Handler.dart';

abstract class AbstractApiHandler<U, T> implements Handler<U, T> {
  final http.Client httpClient;

  AbstractApiHandler({required this.httpClient});

  String toJson(Object obj) => jsonEncode(obj);

  @override
  Future<T> execute(U input) => doExecute(input);

  Future<T> doExecute(U input);

  Future<String> webClientGet(String url, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final defaultHeaders = {'Accept': 'application/json', ...?headers};
    try {
      final response = await httpClient.get(uri, headers: defaultHeaders);
      if (response.statusCode >= 400) {
        throw Exception('External service error (${response.statusCode}): ${response.body}');
      }
      return response.body;
    } catch (e) {
      throw Exception('Unexpected error in webClientGet: $e');
    }
  }

  Future<String> webClientPost(String url, Object request, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final defaultHeaders = {'Content-Type': 'application/json', 'Accept': 'application/json', ...?headers};
    try {
      final response = await httpClient.post(uri, headers: defaultHeaders, body: toJson(request));
      if (response.statusCode >= 400) {
        throw Exception('External service error (${response.statusCode}): ${response.body}');
      }
      return response.body;
    } catch (e) {
      throw Exception('Unexpected error in webClientPost: $e');
    }
  }

  Future<String> webClientDelete(String url, {Map<String, String>? headers}) async {
    final uri = Uri.parse(url);
    final defaultHeaders = {'Accept': 'application/json', ...?headers};
    try {
      final response = await httpClient.delete(uri, headers: defaultHeaders);
      if (response.statusCode >= 400) {
        throw Exception('External service error (${response.statusCode}): ${response.body}');
      }
      return response.body;
    } catch (e) {
      throw Exception('Unexpected error in webClientDelete: $e');
    }
  }
}