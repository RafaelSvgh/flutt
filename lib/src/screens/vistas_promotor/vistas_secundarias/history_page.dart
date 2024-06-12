import 'package:flutter/material.dart';

class HistoryPagePromotor extends StatelessWidget {
  const HistoryPagePromotor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mi Historial',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text('Bienvenido al historial'),
      ),
    );
  }
}
