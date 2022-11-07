import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/error/failures.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/use_cases/get_all_persons.dart';
import 'package:rick_and_morty/feature/domain/use_cases/params/page_person_params.dart';

part 'person_list_state.dart';

class PersonListCubit extends Cubit<PersonListState> {
  PersonListCubit({required this.getAllPersons}) : super(PersonEmptyState());

  final GetAllPersons getAllPersons;
  int page = 1;

  Future<void> loadPersonCubit() async {
    if (state is PersonLoadingState) return;

    final currentState = state;

    List<PersonEntity> oldPerson = <PersonEntity>[];
    if (currentState is PersonLoadedState) {
      oldPerson = currentState.personList;
    }
    emit(PersonLoadingState(oldPersonList: oldPerson, isFirstFetch: page == 1));

    final result = await getAllPersons.call(PagePersonParams(page: page));

    result.fold((error) => emit(PersonErrorState(message: _mapFailureToMessage(error))), (character) {
      page++;
      final persons = (state as PersonLoadingState).oldPersonList;
      persons.addAll(character);
      log('List length: ${persons.length.toString()}');
      emit(PersonLoadedState(personList: persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
