import 'package:equatable/equatable.dart';

class PagePersonParams extends Equatable {
  const PagePersonParams({
    required this.page,
  });

  final int page;

  @override
  List<Object?> get props => [page];
}
