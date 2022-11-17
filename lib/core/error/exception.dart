import 'package:equatable/equatable.dart';

///Ошибки от внешних источников. Например, проблемы при ответе на запрос
class ServerException extends Equatable implements Exception {


  const ServerException();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class CacheException implements Exception {}
