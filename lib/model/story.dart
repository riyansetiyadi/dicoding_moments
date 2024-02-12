class StoryModel {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final DateTime? createdAt;
  final double? lat;
  final double? lon;

  StoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: json.containsKey('createdAt')
            ? DateTime.parse(json["createdAt"])
            : null,
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };
}
