class Punto {
    final int id;
    final int puntos;

    Punto({
        required this.id,
        required this.puntos,
    });

    factory Punto.fromJson(Map<String, dynamic> json) => Punto(
        id: json["id"],
        puntos: json["puntos"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "puntos": puntos,
    };
}
