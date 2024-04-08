import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/core/error/exception.dart';
import 'package:rick_and_morty_app/data/models/person_model.dart';

//Endpoits:
//https://rickandmortyapi.com/api/character/?name=$query
//https://rickandmortyapi.com/api/character/?page=$page

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersones(int page);
  Future<List<PersonModel>> searchPersone(String query);
}

class PersonRemouteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemouteDataSourceImpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersones(int page) => _getPersoneFromUrl(
      "https://rickandmortyapi.com/api/character/?page=$page");

  @override
  Future<List<PersonModel>> searchPersone(String query) => _getPersoneFromUrl(
      "https://rickandmortyapi.com/api/character/?name=$query");

  Future<List<PersonModel>> _getPersoneFromUrl(String url) async {
    final repsonse = await client.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    if (repsonse.statusCode == 200) {
      final persone = json.decode(repsonse.body);
      return (persone["results"] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    }
    throw ServerException();
  }
}
