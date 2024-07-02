import 'package:dio/dio.dart';
import 'package:flutt/src/models/compra.dart';

Future<Compras> historial(int id) async {
  try {
    Response response =
        await Dio().get('http://3.88.182.80/api/prom-historial/$id');

    if (response.statusCode == 200) {
      final compras = Compras.fromJsonList(response.data);
      return compras;
    } else {
      return Compras();
    }
  } catch (e) {
    return Compras();
  }
}
