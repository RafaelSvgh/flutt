import 'package:flutter/material.dart';

class ProductsPagePromotor extends StatelessWidget {
  const ProductsPagePromotor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Productos',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text('Todos los productos'),
      ),
    );
  }
}
