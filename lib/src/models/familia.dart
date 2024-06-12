class Familias {
  List<Familia> items = [];

  Familias();

  Familias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }
    for (var item in jsonList) {
      final familia = new Familia.fromJson(item);
      items.add(familia);
    }
  }
}

class Familia {
  final int id;
  final String nombre;
  final DateTime createdAt;
  final DateTime updatedAt;

  Familia({
    required this.id,
    required this.nombre,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Familia.fromJson(Map<String, dynamic> json) => Familia(
        id: json["id"],
        nombre: json["nombre"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
