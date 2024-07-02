import 'package:flutt/src/models/punto.dart';
import 'package:flutt/src/widgets/rango_card.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PerfilPagePromotor extends StatefulWidget {
  final List<String> usuario;
  const PerfilPagePromotor({super.key, required this.usuario});

  @override
  State<PerfilPagePromotor> createState() => _PerfilPagePromotorState();
}

class _PerfilPagePromotorState extends State<PerfilPagePromotor> {
  Punto? puntos;
  String compras = "";
  double monto = 0.0;
  @override
  void initState() {
    super.initState();
    getPuntos();
    getCompras();
    getMontoComprado();
  }

  Future<void> getPuntos() async {
    try {
      final response = await Dio()
          .get('http://3.88.182.80/api/prom/${int.parse(widget.usuario[0])}');
      setState(() {
        puntos = Punto.fromJson(response.data);
      });
      // ignore: empty_catches
    } catch (error) {}
  }

  Future<void> getCompras() async {
    try {
      final response = await Dio().get(
          'http://3.88.182.80/api/prom-cantidad/${int.parse(widget.usuario[0])}');
      setState(() {
        compras = response.data.toString();
      });
      // ignore: empty_catches
    } catch (error) {}
  }

  Future<void> getMontoComprado() async {
    try {
      final response = await Dio().get(
          'http://3.88.182.80/api/prom-compras/${int.parse(widget.usuario[0])}');
      setState(() {
        monto = double.parse(response.data.toString());
      });
      // ignore: empty_catches
    } catch (error) {}
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mi Perfil',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150.0,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey),
                  child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/5556/5556475.png'),
                ),
                Text(
                  widget.usuario[1],
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 5.0),
                const Text('Esta es una breves descripción sobre mí.'),
                const SizedBox(height: 10.0),
                Text(
                  widget.usuario[2],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 200.0,
                      height: 40.0,
                      margin: const EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue),
                      child: Center(
                        child: Text(
                          'Total compras:  $compras',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      width: 130.0,
                      height: 40.0,
                      margin: const EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300),
                      child: Center(
                        child: Text(
                          'Puntos:  ${puntos?.puntos}',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Divider(),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.military_tech_outlined,
                      size: 70,
                      color: Colors.amber.shade300,
                    ),
                    Text(
                      'Mis logros',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800),
                    )
                  ],
                ),
                rangoCard(monto),
              ],
            ),
          ),
        ));
  }
}
