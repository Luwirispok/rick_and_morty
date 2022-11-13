import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/feature/data/data_sources/person_remote_data_source.dart';
import 'package:rick_and_morty/feature/data/data_sources/personal_local_data_source.dart';
import 'package:rick_and_morty/feature/data/repositories/person_repository_impl.dart';
import 'package:rick_and_morty/feature/domain/repositories/person_repository.dart';
import 'package:rick_and_morty/feature/domain/use_cases/get_all_persons.dart';
import 'package:rick_and_morty/feature/domain/use_cases/search_person.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_search_bloc/person_search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Locator {
  static final injection = GetIt.instance;

  static Future<void> init() async {
    ///Принцип инициализации зависимостей сверху-вниз, согласно потоку вызовов
    ///данных от ui и до отправки запросов
    //Bloc / Cubit - фабрика, т.к. близки к польз. интерфейсу и
    //при закрытии экрана должны очищаться
    injection.registerFactory(() => PersonListCubit(getAllPersons: injection()));
    injection.registerFactory(() => PersonSearchBloc(searchPerson: injection()));

    //UseCases - lazy (ленивый) singleton
    injection.registerLazySingleton(() => GetAllPersons(repository: injection()));
    injection.registerLazySingleton(() => SearchPerson(repository: injection()));

    //Repository
    injection.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
          remoteDataSource: injection(),
          localDataSource: injection(),
          networkInfo: injection(),
        ));

    injection.registerLazySingleton<PersonRemoteDataSource>(
      () => PersonRemoteDataSourceImpl(
        client: http.Client(),
      ),
    );

    injection.registerLazySingleton<PersonLocalDataSource>(
      () => PersonLocalDataSourceImpl(
        sharedPreferences: injection(),
      ),
    );

    //Core (сеть)
    injection.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        connectionChecker: injection(),
      ),
    );

    //External
    final sharedPreferences = await SharedPreferences.getInstance();
    injection.registerLazySingleton(() => sharedPreferences);
    injection.registerLazySingleton(() => http.Client());
    injection.registerLazySingleton(() => InternetConnectionChecker());
  }
}
