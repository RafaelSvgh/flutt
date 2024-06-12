// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>?> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/login'),
    body: {'email': email, 'password': password},
  );
  if (response.statusCode == 200) {
    dynamic data = response.body;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data);
    Map<String, dynamic> mapa = json.decode(data);
    List<String> usuario = [];
    usuario.add(mapa['id'].toString());
    usuario.add(mapa['name']);
    usuario.add(mapa['email']);
    if (mapa['admin']) {
      usuario.add('administrador');
    } else {
      usuario.add('promotor');
    }
    return usuario;
  } else {
    return null;
  }
}
