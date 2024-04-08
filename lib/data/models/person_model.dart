import 'package:rick_and_morty_app/domain/entities/persone_entity.dart';

class PersonModel extends PersonEntity {
  const PersonModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.image,
    required super.origin,
    required super.location,
    required super.episode,
    required super.created,
    required super.originUrl,
    required super.locationUrl,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json["id"] as int,
      name: json["name"] as String,
      status: json["status"] as String,
      species: json["species"] as String,
      type: json["type"] as String,
      gender: json["gender"] as String,
      image: json["image"] as String,
      origin: json["origin"]["name"],
      originUrl: json["origin"]["url"],
      location: json["location"]["name"],
      locationUrl: json["location"]["url"],
      episode:
          (json["episode"] as List<dynamic>).map((e) => e as String).toList(),
      created: DateTime.parse(json["created"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "status": status,
      "species": species,
      "type": type,
      "gender": gender,
      "image": image,
      "origin": origin,
      "location": location,
      "episode": episode,
      "created": created.toIso8601String(),
    };
  }
}
