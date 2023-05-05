class Alimento {
  final int id;
  final String? description;
  final int? time;
  final double? temperature;
  final int? weight;

  Alimento({
    required this.id,
    required this.description,
    required this.time,
    required this.temperature,
    required this.weight,
  });

  factory Alimento.fromJson(Map json) {
    return Alimento(
      id: json['id'],
      description: json['description'],
      time: json['time'],
      temperature: json['temperature'],
      weight: json['weight'],
    );
  }

  Map toJson() {
    return {
      'id': id,
      'description': description,
      'time': time,
      'temperature': temperature,
      'weight': weight,
    };
  }
}
