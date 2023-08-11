import 'dart:convert';

class Configuration {
  Configuration({
    required this.light,
    required this.dark,
  });

  Mode light;
  Mode dark;

  factory Configuration.fromJson(String str) =>
      Configuration.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Configuration.fromMap(Map<String, dynamic> json) => Configuration(
        light: Mode.fromMap(json["light"]),
        dark: Mode.fromMap(json["dark"]),
      );

  Map<String, dynamic> toMap() => {
        "light": light.toMap(),
        "dark": dark.toMap(),
      };
}

class Mode {
  Mode({
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.primaryText,
    required this.primaryBackground,
  });

  int primaryColor;
  int secondaryColor;
  int tertiaryColor;
  int primaryText;
  int primaryBackground;

  factory Mode.fromJson(String str) => Mode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mode.fromMap(Map<String, dynamic> json) {
    return Mode(
      primaryColor: int.parse(json["primaryColor"]),
      secondaryColor: int.parse(json["secondaryColor"]),
      tertiaryColor: int.parse(json["tertiaryColor"]),
      primaryText: int.parse(json["primaryText"]),
      primaryBackground: int.parse(json["primaryBackground"]),
    );
  }

  Map<String, String> toMap() => {
        "primaryColor": '0x${primaryColor.toRadixString(16).toUpperCase()}',
        "secondaryColor": '0x${secondaryColor.toRadixString(16).toUpperCase()}',
        "tertiaryColor": '0x${tertiaryColor.toRadixString(16).toUpperCase()}',
        "primaryText": '0x${primaryText.toRadixString(16).toUpperCase()}',
        "primaryBackground":
            '0x${primaryBackground.toRadixString(16).toUpperCase()}',
      };
}
