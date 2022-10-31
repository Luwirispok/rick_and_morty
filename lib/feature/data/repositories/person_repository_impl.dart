import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/feature/data/data_sources/person_remote_data_source.dart';
import 'package:rick_and_morty/feature/data/data_sources/personal_local_data_source.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() => remoteDataSource.getAllPersons(page));
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() => remoteDataSource.searchPerson(query));
    // return await _getPersonsCopy(await remoteDataSource.searchPerson(query));
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    //Узнаем наличие сети
    if (await networkInfo.isConnected) {
      try {
        //Производим запрос к серверу
        final remotePerson = await getPersons();
        //Сохраняем данные локально (Там же только текущая страница сохранится, а не все прошлые?)
        localDataSource.personsToCache(remotePerson);
        //Возвращаем полученные данные
        return Right(remotePerson);
      } on ServerException {
        //Если при запросе ошибка на сервере, то getPersons() произведет ServerException
        return Left(ServerFailure());
      }

    } else { //Если сети нет
      try {
        //Берем данные из локального хранилища
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      } on CacheException { //Если в sharedPreferences пусто, то произойдет CacheException
        return Left(CacheFailure());
      }
    }
  }

  //Аналог, если не передавать фнкцию в качестве входных параметров

  // Future<Either<Failure, List<PersonModel>>> _getPersonsCopy(
  //     List<PersonModel> remotePerson) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       localDataSource.personsToCache(remotePerson);
  //       return Right(remotePerson);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final locationPerson = await localDataSource.getLastPersonsFromCache();
  //       return Right(locationPerson);
  //     } on CacheException {
  //       return Left(CacheFailure());
  //     }
  //   }
  // }
}
