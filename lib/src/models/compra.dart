class Compras {
  List<Compra> items = [];
  Compras();
  Compras.fromJsonList(List<dynamic> jsonList) {
    for (var item in jsonList) {
      final compra = Compra.fromJson(item);
      items.add(compra);
    }
  }
}

class Compra {
  final int id;
  final DateTime fecha;
  final String montoTotal;
  final List<Detalle> detalle;

  Compra({
    required this.id,
    required this.fecha,
    required this.montoTotal,
    required this.detalle,
  });

  factory Compra.fromJson(Map<String, dynamic> json) => Compra(
        id: json["id"],
        fecha: DateTime.parse(json["fecha"]),
        montoTotal: json["monto_total"],
        detalle:
            List<Detalle>.from(json["detalle"].map((x) => Detalle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "monto_total": montoTotal,
        "detalle": List<dynamic>.from(detalle.map((x) => x.toJson())),
      };
}

class Detalle {
  final int cantidad;
  final String precio;
  final String producto;

  Detalle({
    required this.cantidad,
    required this.precio,
    required this.producto,
  });

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
        cantidad: json["cantidad"],
        precio: json["precio"],
        producto: json["producto"],
      );

  Map<String, dynamic> toJson() => {
        "cantidad": cantidad,
        "precio": precio,
        "producto": producto,
      };
}
