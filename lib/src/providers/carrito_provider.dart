import 'package:flutt/src/models/producto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contadorProvider = StateProvider<int>((ref) {
  return 0;
});

final facturaProvider = StateProvider<String>(
  (ref) {
    return "";
  },
);

final terminadoProvider = StateProvider<bool>((ref) {
  return false;
});

final carritoStateNotifierProvider =
    StateNotifierProvider<CarritoNotifier, List<ProductoCarrito>>((ref) {
  return CarritoNotifier();
});

class CarritoNotifier extends StateNotifier<List<ProductoCarrito>> {
  CarritoNotifier() : super([]);

  void addProducto(int id, String imagen, String nombre, int cantidad,
      double precio, double puntos) {
    final producto =
        ProductoCarrito(id, imagen, nombre, cantidad, precio, puntos);

    if (!existeProducto(producto.id)) {
      state = [
        ...state,
        producto,
      ];
    } else {
      state[buscarIndexProd(producto.id)].addCantidad();
    }
  }

  bool existeProducto(int id) {
    for (var i = 0; i < state.length; i++) {
      if (state[i].id == id) {
        return true;
      }
    }
    return false;
  }

  void setPrecio(int id, int cant, double precio) {
    state[buscarIndexProd(id)].precio = cant * precio;
  }

  int buscarIndexProd(int id) {
    for (var i = 0; i < state.length; i++) {
      if (state[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  void addCantidad(int id) {
    state[buscarIndexProd(id)].addCantidad();
  }

  void subCantidad(int id) {
    final index = buscarIndexProd(id);
    if (index >= 0) {
      final producto = state[index];
      if (producto.cantidad > 0) {
        producto.subCantidad();
      } else {
        state.removeAt(buscarIndexProd(producto.id));
      }
    }
  }

  int cantidadProducto(int id) {
    if (!existeProducto(id)) {
      return 0;
    }
    return state[buscarIndexProd(id)].cantidad;
  }
}
