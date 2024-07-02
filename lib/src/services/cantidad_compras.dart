import 'package:dio/dio.dart';

Future<String> cantidadCompras(int id) async {
  try {
    Response response =
        await Dio().get('http://3.88.182.80/api/prom-cantidad/$id');
    
    if (response.statusCode == 200) {
      print("posi");
      return response.data.toString();
    } else {
      print("no posi");
      return "";
    }
  } catch (e) {
    print("Error: $e");
    return "";
  }
}
