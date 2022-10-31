part of 'person_search_bloc.dart';

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchPersonsEvent extends PersonSearchEvent {
  const SearchPersonsEvent({required this.personQuery});

  final String personQuery;
}