import 'package:equatable/equatable.dart';

import 'location_entity.dart';

//Модель, в которую будут распарсиваться приходящие данные
class PersonEntity extends Equatable {
  const PersonEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.created,
  });

  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationEntity? origin;
  final LocationEntity? location;
  final String image;
  final List<String> episode;
  final DateTime created;

  /*
    Библиотека Equatable позволяет сравнивать объекты по их полям,
    которые задаем в props, а не по id в памяти
   */
  @override
  List<Object?> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        created,
      ];

  @override
  bool get stringify => true;
}
