import 'dart:convert';

class Assets {
  Assets({
    required this.logoColor,
    required this.logoBlanco,
    required this.bg1,
    required this.bgLogin,
  });

  String logoColor;
  String logoBlanco;
  String bg1;
  String bgLogin;

  factory Assets.fromJson(String str) => Assets.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Assets.fromMap(Map<String, dynamic> json) {
    return Assets(
      logoColor: json['logoColor'],
      logoBlanco: json['logoBlanco'],
      bg1: json['bg1'],
      bgLogin: json['bgLogin'],
    );
  }

  Map<String, dynamic> toMap() => {
        "logoColor": logoColor,
        "logoBlanco": logoBlanco,
        "bg1": bg1,
        "bgLogin": bgLogin,
      };
}
