import 'package:equatable/equatable.dart';

class SearchPersonParams extends Equatable {
  const SearchPersonParams({required this.query});

  final String query;

  @override
  List<Object?> get props => [query];
}
