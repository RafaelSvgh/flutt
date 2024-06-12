class Usuario {
  final Data data;
  final String token;

  Usuario({
    required this.data,
    required this.token,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        data: Data.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "token": token,
      };
}

class Data {
  final int id;
  final String name;
  final String email;
  final String profilePhotoUrl;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePhotoUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        profilePhotoUrl: json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profile_photo_url": profilePhotoUrl,
      };
}
