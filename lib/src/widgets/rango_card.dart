import 'package:flutter/material.dart';

Widget rangoCard(double monto) {
  String rango = 'Inicial';
  double inicio = 0.0;
  double fin = 25000;
  Color color = Colors.blue.shade100;
  if (monto != null) {
    if (monto >= 25000.0) {
      rango = 'Principiante';
      inicio = 25000.0;
      fin = 55000;
      color = Colors.blue.shade100;
    }
    if (monto >= 55000.0) {
      rango = 'Intermedio';
      inicio = 55000.0;
      fin = 85000;
      color = Colors.green.shade100;
    }
    if (monto >= 85000.0) {
      rango = 'Avanzado';
      inicio = 85000.0;
      fin = 200000;
      color = Colors.grey.shade100;
    }
    if (monto >= 200000.0) {
      rango = 'Experto';
      inicio = 200000.0;
      fin = 24999.0;
      color = Colors.yellow.shade100;
    }
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    padding: const EdgeInsets.all(15.0),
    width: double.infinity,
    height: 200.0,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(15.0)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Promotor $rango',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            const Icon(
              Icons.workspace_premium_sharp,
              size: 35.0,
            )
          ],
        ),
        Text(
          'Promotor nivel $rango',
          style: TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 25.0,
        ),
        LinearProgressIndicator(
          value: 1 - ((fin - monto!) / (fin - inicio)),
          borderRadius: BorderRadius.circular(15.0),
        ),
        // Text('/   /   /   /',
        //     style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w800)),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          'Monto comprado:  ${monto.toStringAsFixed(2)} Bs',
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
        )
      ],
    ),
  );
}
