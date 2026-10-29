import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login/LoginScreen.dart';
import 'products/ProductsApi.dart';
import 'products/ProductsService.dart';
import 'product_by_id/ProductByIdApi.dart';
import 'product_by_id/ProductByIdService.dart';
import 'carts/CartsApi.dart';
import 'carts/CartsService.dart';

void main() {
  final httpClient = http.Client();

  final productsApi = ProductsApi(httpClient: httpClient);
  final productsService = ProductsService(productsApi: productsApi);

  final productByIdApi = ProductByIdApi(httpClient: httpClient);
  final productByIdService = ProductByIdService(productByIdApi: productByIdApi);

  final cartsApi = CartsApi(httpClient: httpClient);
  final cartsService = CartsService(cartsApi: cartsApi);

  runApp(MyApp(
    productsService: productsService,
    productByIdService: productByIdService,
    cartsService: cartsService,
  ));
}

class MyApp extends StatelessWidget {
  final ProductsService productsService;
  final ProductByIdService productByIdService;
  final CartsService cartsService;

  const MyApp({
    super.key,
    required this.productsService,
    required this.productByIdService,
    required this.cartsService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tienda Examen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E),
          primary: const Color(0xFF1A237E),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A237E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF1A237E),
        ),
      ),
      home: LoginScreen(
        productsService: productsService,
        productByIdService: productByIdService,
        cartsService: cartsService,
      ),
    );
  }
}