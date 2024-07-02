import 'package:flutt/src/models/compra.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HistoryPagePromotor extends StatefulWidget {
  final int id;
  const HistoryPagePromotor({super.key, required this.id});

  @override
  State<HistoryPagePromotor> createState() => _HistoryPagePromotorState();
}

class _HistoryPagePromotorState extends State<HistoryPagePromotor> {
  Compras? compras;

  @override
  void initState() {
    super.initState();
    historial();
  }

  Future<void> historial() async {
    try {
      Response response =
          await Dio().get('http://3.88.182.80/api/prom-historial/${widget.id}');
      setState(() {
        compras = Compras.fromJsonList(response.data);
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mi Historial',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: (compras?.items ?? []).map((compra) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 7.0),
                    width: double.infinity,
                    height: 110.0,
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.shopify_sharp,
                          size: 75.0,
                          color: Colors.black54,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '#${compra.id}',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Fecha: ${compra.fecha.toString().substring(0, 10)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Monto: ${compra.montoTotal} Bs',
                                  style: const TextStyle(fontSize: 17.0),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(50.0)),
                          child: IconButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          width: double.infinity,
                                          height: 400.0,
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: (compra.detalle)
                                                  .map((detalle) {
                                                return ListTile(
                                                  title: Text(
                                                    detalle.producto,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  subtitle: Text(
                                                      '${detalle.precio}Bs | Cantidad: ${detalle.cantidad}'),
                                                );
                                              }).toList()));
                                    });
                              },
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30,
                              )),
                        )
                      ],
                    ),
                  );
                }).toList()),
          ),
        ));
  }
}
