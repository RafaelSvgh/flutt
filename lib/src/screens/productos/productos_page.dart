import 'package:flutt/src/models/producto.dart';
import 'package:flutt/src/providers/carrito_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductoPage extends ConsumerStatefulWidget {
  final Producto producto;
  const ProductoPage({
    super.key,
    required this.producto,
    required Producto Producto,
  });

  @override
  ProductoPageState createState() => ProductoPageState();
}

class ProductoPageState extends ConsumerState<ProductoPage> {
  Producto? producto;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contador = ref.watch(contadorProvider);
    final carrito = ref.watch(carritoStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.grey.shade600),
        title: Text('Comfy Home',
            style: TextStyle(
                color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Finalizar compra'),
        icon: const Icon(Icons.payment),
      ),
      endDrawer: SafeArea(
        child: Drawer(
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Image.network(widget.producto.imagen),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Text(
                widget.producto.nombre,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Text(
                    'Bs ${widget.producto.precio}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  )),
                  Container(
                    height: 40.0,
                    margin: const EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.blue),
                    child: Row(
                      children: [
                        IconButton(
                            enableFeedback: true,
                            onPressed: () {
                              ref
                                  .read(carritoStateNotifierProvider.notifier)
                                  .subCantidad(widget.producto.id);

                              ref
                                  .read(contadorProvider.notifier)
                                  .update((state) => carrito.length);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            )),
                        Text(
                          ref
                              .read(carritoStateNotifierProvider.notifier)
                              .cantidadProducto(widget.producto.id)
                              .toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        IconButton(
                            onPressed: () {
                              ref
                                  .read(carritoStateNotifierProvider.notifier)
                                  .addProducto(
                                      widget.producto.id,
                                      widget.producto.imagen,
                                      widget.producto.nombre,
                                      1,
                                      double.parse(widget.producto.precio),
                                      double.parse(widget.producto.puntos));
                              setState(() {});

                              final carritoProd =
                                  ref.watch(carritoStateNotifierProvider);

                              ref
                                  .read(contadorProvider.notifier)
                                  .update((state) => carritoProd.length);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: const Text(
                'Descripción:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(),
              child: Text(
                widget.producto.descripcion,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Positioned(child: Container()),
          ],
        ),
      ),
    );
  }
}
