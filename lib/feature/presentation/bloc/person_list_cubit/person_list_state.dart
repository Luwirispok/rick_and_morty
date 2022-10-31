part of 'person_list_cubit.dart';

abstract class PersonListState extends Equatable {
  const PersonListState();

  @override
  List<Object> get props => [];
}

class PersonEmptyState extends PersonListState {
  @override
  List<Object> get props => [];
}

class PersonLoadingState extends PersonListState {
  final List<PersonEntity> oldPersonList;
  final bool isFirstFetch;

  const PersonLoadingState({
    required this.oldPersonList,
    required this.isFirstFetch,
  });

  @override
  List<Object> get props => [oldPersonList];
}

class PersonLoadedState extends PersonListState {
  final List<PersonEntity> personList;

  const PersonLoadedState({required this.personList});

  @override
  List<Object> get props => [personList];
}

class PersonErrorState extends PersonListState {
  final String message;

  const PersonErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
