import 'package:flutter/material.dart';
import '../products/ProductsScreen.dart';
import '../products/ProductsService.dart';
import '../product_by_id/ProductByIdService.dart';
import '../carts/CartsService.dart';

class LoginScreen extends StatefulWidget {
  final ProductsService productsService;
  final ProductByIdService productByIdService;
  final CartsService cartsService;

  const LoginScreen({
    super.key,
    required this.productsService,
    required this.productByIdService,
    required this.cartsService,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ProductsScreen(
            productsService: widget.productsService,
            productByIdService: widget.productByIdService,
            cartsService: widget.cartsService,
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Error al iniciar sesión.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.storefront, color: Color(0xFF1A237E), size: 32),
                    const SizedBox(width: 8),
                    const Text(
                      'TIENDA EXAMEN',
                      style: TextStyle(
                        color: Color(0xFF1A237E),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Usuario / Correo',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      (value == null || value.trim().isEmpty) ? 'Ingresa tu usuario' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Contraseña',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onFieldSubmitted: (_) => _submit(),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Ingresa tu contraseña' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Aceptar'),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}