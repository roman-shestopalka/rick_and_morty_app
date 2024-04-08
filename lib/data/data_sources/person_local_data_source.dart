import 'package:rick_and_morty_app/core/error/exception.dart';
import 'package:rick_and_morty_app/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String cashePersonList = "CASHED_PERSONS_LIST";

abstract class PersonLocalDataSources {
  Future<List<PersonModel>> getLastPersonsFromCashe();
  Future<void> personsToCashe(List<PersonModel> persons);
}

class PersonLocalDataSourcesImpl implements PersonLocalDataSources {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCashe() {
    final jsonPersonsList = sharedPreferences.getStringList(cashePersonList);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CasheException();
    }
  }

  @override
  Future<void> personsToCashe(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((persons) => json.encode(persons.toJson())).toList();

    sharedPreferences.setStringList(cashePersonList, jsonPersonsList);
    return Future.value(jsonPersonsList);
  }
}
