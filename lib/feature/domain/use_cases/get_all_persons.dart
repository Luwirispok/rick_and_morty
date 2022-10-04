import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/failures.dart';
import 'package:rick_and_morty/core/use_cases/use_case.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

import 'params/page_person_params.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  GetAllPersons({required this.repository});

  PersonRepository repository;

  @override
  Future<Either<Failure, List<PersonEntity>>> call(PagePersonParams params) async {
    return await repository.getAllPersons(params.page);
  }
}
