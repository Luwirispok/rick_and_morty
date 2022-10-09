import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

import 'params/search_person_params.dart';

class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams> {
  SearchPerson({required this.repository});

  PersonRepository repository;

  @override
  Future<Either<Failure, List<PersonEntity>>> call(SearchPersonParams params) async {
    return await repository.searchPerson(params.query);
  }
}
