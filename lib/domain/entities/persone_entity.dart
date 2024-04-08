import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String origin;
  final String location;
  final String locationUrl;
  final String originUrl;
  final List<String> episode;
  final DateTime created;

  const PersonEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.origin,
    required this.originUrl,
    required this.locationUrl,
    required this.location,
    required this.episode,
    required this.created,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        image,
        origin,
        location,
        episode,
        created,
      ];
}

class LocationEntity {
  final String name;
  final String url;

  LocationEntity({
    required this.name,
    required this.url,
  });
}
