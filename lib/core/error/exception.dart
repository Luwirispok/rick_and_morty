///Ошибки от внешних источников. Например, проблемы при ответе на запрос
class ServerException implements Exception {
  final int code;

  ServerException({required this.code});
}

class CacheException implements Exception {}
