import 'package:flutt/src/services/reporte_compra_excel.dart';
import 'package:flutt/src/services/reporte_compra_pdf.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Reporte de mis compras',
            style: TextStyle(fontSize: 22.0),
          ),
          const SizedBox(
            height: 70.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Colors.brown.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Descargar reporte en PDF',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    final reporte = await reportePDF(3);
                    launch(reporte);
                  },
                  icon: Icon(
                    Icons.picture_as_pdf,
                    color: Colors.brown.shade600,
                    size: 40.0,
                  ))
            ],
          ),
          const SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  'Descargar reporte en Excel',
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    final reporte = await reporteExcel(3);
                    launch(reporte);
                  },
                  icon: Icon(
                    Icons.grid_on_rounded,
                    color: Colors.green.shade600,
                    size: 40.0,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
