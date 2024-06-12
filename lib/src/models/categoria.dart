class Categorias {
  List<Categoria> items = [];
  Categorias();

  Categorias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }
    for (var item in jsonList) {
      final categoria = new Categoria.fromJson(item);
      items.add(categoria);
    }
  }
}

class Categoria {
  final int id;
  final String nombre;
  final int familiaId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Categoria({
    required this.id,
    required this.nombre,
    required this.familiaId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["id"],
        nombre: json["nombre"],
        familiaId: json["familia_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "familia_id": familiaId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
