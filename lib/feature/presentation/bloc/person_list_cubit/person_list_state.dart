part of 'person_list_cubit.dart';

abstract class PersonListState extends Equatable {
  const PersonListState();

  @override
  List<Object> get props => [];
}

class PersonEmpty extends PersonListState {
  @override
  List<Object> get props => [];
}

class PersonLoading extends PersonListState {
  final List<PersonEntity> oldPersonList;
  final bool isFirstFetch;

  const PersonLoading({
    required this.oldPersonList,
    required this.isFirstFetch,
  });

  @override
  List<Object> get props => [oldPersonList];
}

class PersonLoaded extends PersonListState {
  final List<PersonEntity> personList;

  const PersonLoaded({required this.personList});

  @override
  List<Object> get props => [personList];
}

class PersonError extends PersonListState {
  final String message;

  const PersonError({required this.message});

  @override
  List<Object> get props => [message];
}
