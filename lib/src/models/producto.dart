class Productos {
  List<Producto> items = [];
  Productos();
  Productos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }
    for (var item in jsonList) {
      final producto = new Producto.fromJson(item);
      items.add(producto);
    }
  }
}

class Producto {
  final int id;
  final String nombre;
  final int stock;
  final String descripcion;
  final String precio;
  final String puntos;
  final String imagen;
  final int subcategoriaId;

  Producto({
    required this.id,
    required this.nombre,
    required this.stock,
    required this.descripcion,
    required this.precio,
    required this.puntos,
    required this.imagen,
    required this.subcategoriaId,
  });

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["id"],
        nombre: json["nombre"],
        stock: json["stock"],
        descripcion: json["descripcion"],
        precio: json["precio"],
        puntos: json["puntos"],
        imagen: json["imagen"],
        subcategoriaId: json["subcategoria_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "stock": stock,
        "descripcion": descripcion,
        "precio": precio,
        "puntos": puntos,
        "imagen": imagen,
        "subcategoria_id": subcategoriaId,
      };
}

class ProductoCarrito {
  int id;
  String imagen;
  String nombre;
  int cantidad;
  double precio;
  double puntos;

  ProductoCarrito(this.id, this.imagen, this.nombre, this.cantidad, this.precio,
      this.puntos);

  Map<String, dynamic> toJson() => {
        "id": id,
        "imagen": imagen,
        "cantidad": cantidad,
        "nombre": nombre,
        "precio": precio,
        "puntos": puntos,
      };

  void addCantidad() {
    cantidad++;
  }

  void subCantidad() {
    cantidad--;
  }

  void setPrecio(double precio) {
    this.precio = precio;
  }
}
