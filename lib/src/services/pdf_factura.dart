import 'package:dio/dio.dart';
import 'package:flutt/src/models/producto.dart';

Future<String> pdfFactura(List<ProductoCarrito> productos, int id) async {
  try {
    List<Map<String, dynamic>> productosJson =
        productos.map((producto) => producto.toJson()).toList();

    final response = await Dio()
        // .get('http://10.0.2.2:8000/api/pdf-factura/$id', data: productosJson);
        .get('http://3.88.182.80/api/pdf-factura/$id', data: productosJson);

    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      return "f no";
    }
  } catch (e) {
    return ("Error: $e");
  }
}
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:dio/dio.dart';
// import 'package:flutt/src/models/producto.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// Future<void> pdfFactura(List<ProductoCarrito> productos, int id) async {
//   try {
//     Directory? directory = await getExternalStorageDirectory();
//     List<Map<String, dynamic>> productosJson =
//         productos.map((producto) => producto.toJson()).toList();
//     final response = await Dio().download(
//         'http://10.0.2.2:8000/api/pdf-factura/$id/$productos',
//         '${directory!.path}/factura.pdf',
//         queryParameters: {'productosJson': productosJson});
//     print(response.statusCode);
//   } catch (e) {
//     print('Error: $e');
//   }
// }
// import 'dart:io';
// import 'package:flutt/src/models/producto.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';

// import 'dart:convert';

// Future<void> pdfFactura(List<ProductoCarrito> productos, int id) async {
//   try {
//     // Convertir la lista de productos a una cadena JSON
//     String productosJsonString =
//         jsonEncode(productos.map((producto) => producto.toJson()).toList());

//     // Realizar la solicitud HTTP GET para descargar el PDF
//     final response = await http.get(
//       Uri.parse(
//           'http://10.0.2.2:8000/api/pdf-factura/$id/$productosJsonString'),
//     );

//     if (response.statusCode == 200) {
//       final Directory? directorio = await getExternalStorageDirectory();
//       final String filePath = '${directorio?.path}/factura.pdf';

//       final File file = File(filePath);
//       await file.writeAsBytes(response.bodyBytes);

//       if (await file.exists()) {
//         print('Descarga completa: $filePath');
//       } else {
//         print('Error al descargar el archivo');
//       }
//     } else {
//       print('Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
