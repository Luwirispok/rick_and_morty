import 'dart:io';

import 'package:equatable/equatable.dart';

///Ошибки от внешних источников. Например, проблемы при ответе на запрос
class ServerException extends Equatable implements Exception {
  final int code;

  const ServerException({required this.code});

  @override
  List<Object?> get props => [code];

  @override
  bool get stringify => true;
}

class CacheException implements Exception {}
