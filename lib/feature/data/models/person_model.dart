import 'package:rick_and_morty/feature/data/models/location_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

//Мы подключили модель PersonEntity из domain, чтобы модель полностью повторяла свою начинку
class PersonModel extends PersonEntity {
  const PersonModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.type,
    required super.gender,
    required super.origin,
    required super.location,
    required super.image,
    required super.episode,
    required super.created,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: json['origin'] != null ? LocationModel.fromJson(json['origin']): null, //если эти поля пустые, то будет ошибка
        location: json['location'] != null ? LocationModel.fromJson(json['location']): null, //если эти поля пустые, то будет ошибка
        image: json['image'],
        episode: (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
        created: DateTime.parse(json['created'] as String),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': origin,
        'location': location,
        'image': image,
        'episode': episode,
        'created': created.toString(),
      };
}
