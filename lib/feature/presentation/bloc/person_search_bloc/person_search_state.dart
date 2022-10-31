part of 'person_search_bloc.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();

  @override
  List<Object> get props => [];
}

class PersonEmptyState extends PersonSearchState {}

class PersonSearchLoadingState extends PersonSearchState {}

class PersonSearchLoadedState extends PersonSearchState {
  const PersonSearchLoadedState({required this.persons});

  final List<PersonEntity> persons;

  @override
  List<Object> get props => [persons];
}

class PersonSearchErrorState extends PersonSearchState {
  const PersonSearchErrorState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
