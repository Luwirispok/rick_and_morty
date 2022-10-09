import 'dart:convert';

import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  /// Calls the https://rickandmortyapi.com/api/character/?page=1 endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PersonModel>> getAllPersons(int page);

  /// Calls the https://rickandmortyapi.com/api/character/?name=rick endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PersonModel>> searchPerson(String query);
}

const String baseUrl = 'https://rickandmortyapi.com/api/character/';

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  late final http.Client client;

  @override
  Future<List<PersonModel>> getAllPersons(int page) async {
    return _getPersonFromUrl('$baseUrl?page=$page');
  }

  @override
  Future<List<PersonModel>> searchPerson(String query) {
    return _getPersonFromUrl('$baseUrl?name=$query');
  }

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    final uri = Uri.parse(url);
    final headers = {'Content-Type': 'application/json'};
    final result = await client.get(uri, headers: headers);
    int? code = result.statusCode;
    if (code.toString().startsWith('2')) {
      final data = json.decode(result.body);
      return (data['result'] as List).map((person) => PersonModel.fromJson(person)).toList();
    } else {
      throw ServerException(code: code);
    }
  }
}
