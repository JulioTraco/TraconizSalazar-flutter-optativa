import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/carrito.dart';
import '../widgets/carrito_item.dart';
import 'productos_screen.dart';

const List<Map<String, dynamic>> _carritosDummy = [
  {
    "id": 1,
    "userId": 1,
    "date": "2020-03-02T00:00:00.000Z",
    "products": [
      {"productId": 1, "quantity": 4},
      {"productId": 2, "quantity": 1},
      {"productId": 3, "quantity": 6},
    ]
  },
  {
    "id": 2,
    "userId": 1,
    "date": "2020-01-02T00:00:00.000Z",
    "products": [
      {"productId": 2, "quantity": 4},
      {"productId": 1, "quantity": 10},
      {"productId": 5, "quantity": 2},
    ]
  },
  {
    "id": 3,
    "userId": 2,
    "date": "2020-03-02T00:00:00.000Z",
    "products": [
      {"productId": 1, "quantity": 2},
      {"productId": 9, "quantity": 1},
    ]
  },
  {
    "id": 4,
    "userId": 3,
    "date": "2020-01-02T00:00:00.000Z",
    "products": [
      {"productId": 1, "quantity": 4},
    ]
  },
  {
    "id": 5,
    "userId": 3,
    "date": "2020-03-02T00:00:00.000Z",
    "products": [
      {"productId": 7, "quantity": 1},
      {"productId": 8, "quantity": 3},
    ]
  },
  {
    "id": 6,
    "userId": 4,
    "date": "2020-01-02T00:00:00.000Z",
    "products": [
      {"productId": 1, "quantity": 4},
    ]
  },
  {
    "id": 7,
    "userId": 8,
    "date": "2020-03-02T00:00:00.000Z",
    "products": [
      {"productId": 1, "quantity": 2},
      {"productId": 2, "quantity": 1},
    ]
  },
];

class CarritosScreen extends StatefulWidget {
  const CarritosScreen({super.key});

  @override
  State<CarritosScreen> createState() => _CarritosScreenState();
}

class _CarritosScreenState extends State<CarritosScreen> {
  List<Carrito> _carritos = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _cargarCarritos();
  }

  Future<void> _cargarCarritos() async {
    try {
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/carts'),
      ).timeout(const Duration(seconds: 5));

      print('STATUS CARRITOS: ${response.statusCode}');
      print('BODY CARRITOS: ${response.body}');

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        setState(() {
          _carritos = data.map((c) => Carrito.fromJson(c)).toList();
          _loading = false;
        });
      } else {
        _cargarDummy();
      }
    } catch (e) {
      print('ERROR CARRITOS: $e');
      _cargarDummy();
    }
  }

  void _cargarDummy() {
    setState(() {
      _carritos = _carritosDummy.map((c) => Carrito.fromJson(c)).toList();
      _loading = false;
    });
  }

  int _selectedIndex = 1;

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProductosScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carritos de compra'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: _carritos.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return CarritoItem(carrito: _carritos[index]);
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        selectedItemColor: const Color(0xFF1A237E),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Carritos',
          ),
        ],
      ),
    );
  }
}