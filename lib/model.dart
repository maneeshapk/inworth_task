class Heros {
  final String name;
  final String power;
  final String url;

  Heros({required this.name, required this.power, required this.url});

  factory Heros.fromMap(Map<String, dynamic> json) {
    return Heros(
      name: json['name'],
      power: json['power'],
      url: json['url'],
    );
  }
}
