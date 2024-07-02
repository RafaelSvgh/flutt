import 'package:dio/dio.dart';

Future<String> reportePDF(int id) async {
  try {
    final response = await Dio()
        // .get('http://10.0.2.2:8000/api/pdf-factura/$id', data: productosJson);
        .get('http://3.88.182.80/api/prom-pdf/$id');

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
