class MainModel {
  final String? sensor;

  MainModel({
    required this.sensor,
  });

  factory MainModel.fromJson(Map json) {
    return MainModel(
      sensor: json['sensor'],
    );
  }

  Map toJson() {
    return {
      'sensor': sensor,
    };
  }
}
