import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/use_cases/params/search_person_params.dart';
import 'package:rick_and_morty/feature/domain/use_cases/search_person.dart';

part 'person_search_event.dart';

part 'person_search_state.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPersonsEvent>(_onSearchPersonsEvent);
  }

  final SearchPerson searchPerson;

  FutureOr<void> _onSearchPersonsEvent(SearchPersonsEvent event, Emitter<PersonSearchState> emit) async {
    emit(PersonSearchLoading());
    List<PersonEntity>? data;
    Failure? error;

    final result = await searchPerson.call(SearchPersonParams(query: event.personQuery));
    emit(result.fold(
      (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
      (person) => PersonSearchLoaded(persons: person),
    ));
  }

  // result.fold(
  //   (failure) => error = failure,
  //   (answer) => data = answer,
  // );
  //   if(error == null){
  //     emit(PersonSearchLoadedState(persons: data!));
  //   } else{
  //     emit(PersonSearchErrorState(message: _mapFailureToMessage(error!)));
  //   }

  String _mapFailureToMessage(Failure error) {
    switch (error.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unidentified Error';
    }
  }
}
