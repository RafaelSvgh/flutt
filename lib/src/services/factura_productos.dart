import 'package:dio/dio.dart';
import 'package:flutt/src/models/producto.dart';

Future<void>? facturaProducto(List<ProductoCarrito> productos, int id) async {
  try {
    List<Map<String, dynamic>> productosJson =
        productos.map((producto) => producto.toJson()).toList();

    Response response = await Dio()
        .post('http://3.88.182.80/api/factura/$id', data: productosJson);

    if (response.statusCode == 200) {
      print("posi");
    } else {
      print("no posi");
    }
  } catch (e) {
    print("Error: $e");
  }
}
