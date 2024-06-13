import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutt/src/controllers/payment_controller.dart';
import 'package:flutt/src/models/categoria.dart';
import 'package:flutt/src/models/familia.dart';
import 'package:flutt/src/models/producto.dart';
import 'package:flutt/src/providers/carrito_provider.dart';
import 'package:flutt/src/screens/login/login_page.dart';
import 'package:flutt/src/screens/productos/productos_categoria.dart';
import 'package:flutt/src/screens/productos/productos_page.dart';
import 'package:flutt/src/screens/vistas_promotor/vistas_secundarias/history_page.dart';
import 'package:flutt/src/screens/vistas_promotor/vistas_secundarias/perfil_page.dart';
import 'package:flutt/src/screens/vistas_promotor/vistas_secundarias/products_page.dart';
import 'package:flutt/src/screens/vistas_promotor/vistas_secundarias/reportes_page.dart';
import 'package:flutt/src/services/actualizar_puntos.dart';
import 'package:flutt/src/services/factura_productos.dart';
import 'package:flutt/src/services/pdf_factura.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PromotorView extends ConsumerStatefulWidget {
  final List<String> usuario;
  const PromotorView({super.key, required this.usuario});

  @override
  PromotorViewState createState() => PromotorViewState();
}

class PromotorViewState extends ConsumerState<PromotorView> {
  Familias? familias;
  Categorias? categorias;
  Productos? productos;
  int selectedIndex = 2;
  @override
  void initState() {
    super.initState();
    getFamilias();
    getCategorias();
    getProductos();
  }

  void _contadorInc() {
    setState(() {});
  }

  void _incrementar() {
    _contadorInc();
  }

  Future<void> getFamilias() async {
    try {
      final response = await Dio().get('http://3.88.182.80/api/familias');
      setState(() {
        familias = Familias.fromJsonList(response.data);
      });
      // ignore: empty_catches
    } catch (error) {}
  }

  Future<void> getCategorias() async {
    try {
      final response = await Dio().get('http://3.88.182.80/api/categorias');
      setState(() {
        categorias = Categorias.fromJsonList(response.data);
      });
      // ignore: empty_catches
    } catch (error) {}
  }

  Future<void> getProductos() async {
    try {
      final response = await Dio().get('http://3.88.182.80/api/productos');
      setState(() {
        productos = Productos.fromJsonList(response.data);
      });
      // ignore: empty_catches
    } catch (error) {}
  }

  Future<Productos?> getProductosCategoria(int id) async {
    final response =
        await Dio().get('http://3.88.182.80/api/productos-categoria/$id');
    final prodsCategoria = Productos?.fromJsonList(response.data);
    return prodsCategoria;
  }

  @override
  Widget build(BuildContext context) {
    final contador = ref.watch(contadorProvider);
    final carrito = ref.watch(carritoStateNotifierProvider);
    final terminado = ref.watch(terminadoProvider);
    final link = ref.watch(facturaProvider);
    final PaymentController paymentController = Get.put(PaymentController());

    final pages = [
      PromotorView(usuario: widget.usuario),
      PerfilPagePromotor(usuario: widget.usuario),
      const ProductsPagePromotor(),
      const ReportPagePromotor(),
      const HistoryPagePromotor(),
      const LoginPage()
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.grey.shade600),
          title: Text(
            'Comfy Home',
            style: TextStyle(
                color: Colors.grey.shade600, fontWeight: FontWeight.w500),
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons
                          .shopping_cart), // Icono personalizado para el endDrawer
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                    Positioned(
                      right: 5.0,
                      child: Container(
                        width: 17.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Center(
                            child: Text(
                          contador.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
        drawer: NavigationDrawer(
          onDestinationSelected: (value) {
            setState(() {
              selectedIndex = value;
            });
            final itemMenu = pages[selectedIndex];
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => itemMenu));
          },
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.usuario[1]),
              accountEmail: Text(widget.usuario[2]),
              currentAccountPicture: const CircleAvatar(
                child: ClipOval(
                    child: Icon(
                  Icons.person_pin,
                  size: 70.0,
                  color: Colors.blue,
                )),
              ),
              decoration: const BoxDecoration(color: Colors.indigoAccent),
            ),
            const NavigationDrawerDestination(
                icon: Icon(Icons.home), label: Text('Inicio')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.person), label: Text('Perfil')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.shopping_bag_rounded),
                label: Text('Productos')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.assessment), label: Text('Reportes')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.receipt_long), label: Text('Historial')),
            const Divider(
              height: 60.0,
              endIndent: 20.0,
              indent: 20.0,
            ),
            const SizedBox(
              height: 100.0,
            ),
            const NavigationDrawerDestination(
                icon: Icon(Icons.logout_outlined), label: Text('Salir')),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (carrito.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('El carrito está vacío...'),
                  duration: Duration(milliseconds: 2000),
                ),
              );
            } else {
              double monto = 0;
              double puntos = 0;
              for (var i = 0; i < carrito.length; i++) {
                monto = monto + (carrito[i].precio * carrito[i].cantidad);
                puntos = puntos + (carrito[i].puntos * carrito[i].cantidad);
              }
              int total = (monto * 100).toInt();
              await paymentController.makePayment(
                  amount: total.toString(),
                  currency: 'BOB',
                  ref: ref,
                  context: context,
                  puntos: puntos,
                  id: int.parse(widget.usuario[0]));
            }
          },
          label: const Text('Finalizar compra'),
          icon: const Icon(Icons.payment),
        ),
        endDrawer: Drawer(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView.builder(
                itemCount: carrito.length,
                itemBuilder: (context, index) {
                  final producto = carrito[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.network(
                            producto.imagen,
                            width: 50,
                          ),
                          Container(
                            width: 100.0,
                            height: 60.0,
                            alignment: Alignment.center,
                            child: Text(
                              producto.nombre,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                ref
                                    .read(carritoStateNotifierProvider.notifier)
                                    .subCantidad(producto.id);
                                ref
                                    .read(contadorProvider.notifier)
                                    .update((state) => carrito.length);
                                setState(() {});
                              },
                              icon: const Icon(Icons.remove)),
                          Text(producto.cantidad.toString()),
                          IconButton(
                              onPressed: () {
                                ref
                                    .read(carritoStateNotifierProvider.notifier)
                                    .addCantidad(producto.id);
                                ref
                                    .read(contadorProvider.notifier)
                                    .update((state) => carrito.length);
                                setState(() {});
                              },
                              icon: const Icon(Icons.add)),
                          Text('${producto.precio * producto.cantidad} Bs'),
                        ],
                      ),
                      const Divider(
                        indent: 7.0,
                        endIndent: 7.0,
                      ),
                    ],
                  );
                })),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15.0),
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(
                    "https://media.infocielo.com/p/109c9855c4db03ac15bcc5b82e0b2c5e/adjuntos/299/imagenes/001/715/0001715170/825x464/smart/mueblesjpg.jpg",
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: (categorias?.items ?? []).map((categoria) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: OutlinedButton(
                            onPressed: () async {
                              var productosCategoria =
                                  await getProductosCategoria(categoria.id);

                              Navigator.of(context).push(
                                  MaterialPageRoute<Null>(
                                      builder: (BuildContext context) {
                                return ProductosCategoriaPage(
                                  productos: productosCategoria,
                                  categoria: categoria.nombre,
                                );
                              }));
                            },
                            child: Text(categoria.nombre)),
                      );
                    }).toList()),
              ),
              const SizedBox(
                height: 22.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15.0, bottom: 3.0),
                    child: const Text(
                      'Novedades',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              _Cards(productos, context, _incrementar),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 15.0, bottom: 3.0),
                child: const Text(
                  'Tecnología',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
              ),
              _Cards(productos, context, _incrementar),
              IconButton(
                  onPressed: () async {
                    await pdfFactura(carrito, int.parse(widget.usuario[0]));
                  },
                  icon: const Icon(Icons.abc))
            ],
          ),
        ),
      ),
    );
  }
}

Widget _Cards(
    Productos? lista, BuildContext context, VoidCallback _incrementar) {
  return Container(
    height: 290,
    child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 7.0,
        ),
        children: (lista?.items ?? []).map((producto) {
          return Container(
            width: 180,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 7.0),
            child: _card(
                producto.id,
                producto.nombre,
                producto.stock,
                producto.precio,
                producto.puntos,
                producto.imagen,
                context,
                _incrementar),
          );
        }).toList()),
  );
}

Future<Producto> getProducto(int id) async {
  final response = await Dio().get('http://3.88.182.80/api/producto/$id');
  final producto = Producto?.fromJson(response.data);
  return producto;
}

Widget _card(int id, String nombre, int stock, String precio, String puntos,
    String imagen, BuildContext context, VoidCallback _incrementar) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: () async {
          Producto prod = await getProducto(id);
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return ProductoPage(
              Producto: prod,
              producto: prod,
            );
          }));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.network(imagen),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          nombre,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Bs $precio',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                  onPressed: () {
                    ref
                        .read(contadorProvider.notifier)
                        .update((state) => state + 1);
                    ref.read(carritoStateNotifierProvider.notifier).addProducto(
                        id,
                        imagen,
                        nombre,
                        1,
                        double.parse(precio),
                        double.parse(puntos));
                    final carrito = ref.watch(carritoStateNotifierProvider);
                    ref
                        .read(contadorProvider.notifier)
                        .update((state) => carrito.length);
                  },
                  icon: const Icon(Icons.add_shopping_cart_rounded,
                      color: Colors.blue));
            },
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Puntos: '),
          Text(
            puntos,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
  );
}
