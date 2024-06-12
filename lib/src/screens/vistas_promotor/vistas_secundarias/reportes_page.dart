import 'package:flutter/material.dart';

class ReportPagePromotor extends StatelessWidget {
  const ReportPagePromotor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Reportes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text('Bienvenido a los reportes'),
      ),
    );
  }
}
