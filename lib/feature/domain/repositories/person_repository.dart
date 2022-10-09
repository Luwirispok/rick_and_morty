import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

//Контракт, который будет реализован в Data/Repository
abstract class PersonRepository {

  /*
  Either<L, R> позволяет обрабатывать ошибки и данные полученные при запросе
  Разницы в какой дженерик записывать нет, как удобно
   */
  //Получить всех персонажей с определенной страницы
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);

  //Получить список персонажей на основе поиска
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
