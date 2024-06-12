import 'package:dio/dio.dart';

Future<void>? actualizarPuntos(int id, double puntos) async {
  try {
    Response response = await Dio().put(
      'http://10.0.2.2:8000/api/promotor/$id',
      data: {'puntos': puntos},
    );

    if (response.statusCode == 200) {
      print("posi");
    } else {
      print("no posi");
    }
  } catch (e) {
    print("Error: $e");
  }
}
