import 'package:dio/dio.dart';

Future<void>? actualizarPuntos(int id, double puntos) async {
  try {
    Response response = await Dio().put(
      'http://3.88.182.80/api/promotor/$id',
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
