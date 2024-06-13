import 'package:flutt/src/models/producto.dart';
import 'package:flutt/src/screens/productos/productos_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ProductosCategoriaPage extends StatefulWidget {
  final Productos? productos;
  final String categoria;
  const ProductosCategoriaPage(
      {super.key, required this.productos, required this.categoria});

  @override
  State<ProductosCategoriaPage> createState() => _ProductosCategoriaPageState();
}

Future<Producto> getProducto(int id) async {
  final response = await Dio().get('http://3.88.182.80/api/producto/$id');
  final producto = Producto?.fromJson(response.data);
  return producto;
}

class _ProductosCategoriaPageState extends State<ProductosCategoriaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.categoria,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: (widget.productos?.items ?? []).map((producto) {
                        return Container(
                            height: 280,
                            width: 180,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Producto prod =
                                        await getProducto(producto.id);
                                    Navigator.of(context).push(
                                        MaterialPageRoute<Null>(
                                            builder: (BuildContext context) {
                                      return ProductoPage(
                                        Producto: prod,
                                        producto: prod,
                                      );
                                    }));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.network(producto.imagen),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    producto.nombre,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        'Bs ${producto.precio}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.add_shopping_cart_rounded,
                                            color: Colors.blue))
                                  ],
                                )
                              ],
                            ));
                      }).toList()),
                )
              ],
            ),
          ),
        ));
  }
}
