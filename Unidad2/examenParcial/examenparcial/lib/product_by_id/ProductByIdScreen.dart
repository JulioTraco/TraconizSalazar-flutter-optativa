import 'package:flutter/material.dart';
import '../product_by_id/ProductByIdService.dart';
import '../products/Product.dart';

class ProductByIdScreen extends StatefulWidget {
  final ProductByIdService productByIdService;
  final int? initialId;

  const ProductByIdScreen({
    super.key,
    required this.productByIdService,
    this.initialId,
  });

  @override
  State<ProductByIdScreen> createState() => _ProductByIdScreenState();
}

class _ProductByIdScreenState extends State<ProductByIdScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  Product? _product;

  @override
  void initState() {
    super.initState();
    if (widget.initialId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadProduct(widget.initialId!);
      });
    }
  }

  Future<void> _loadProduct(int id) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _product = null;
    });

    try {
      final product = await widget.productByIdService.getProductById(id);
      if (!mounted) return;
      setState(() => _product = product);
    } catch (_) {
      if (!mounted) return;
      setState(() => _errorMessage = 'No se pudo obtener el producto.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del producto')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _product == null
                  ? const Center(child: Text('Sin producto'))
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _product!.title,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Image.network(
                              _product!.image,
                              height: 200,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image_not_supported, size: 100),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _product!.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              'Precio: \$${_product!.price}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A237E),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_shopping_cart),
                                  label: const Text('Agregar'),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Eliminar'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
    );
  }
}