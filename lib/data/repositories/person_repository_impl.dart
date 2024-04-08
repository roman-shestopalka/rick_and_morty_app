import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/core/error/exception.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/core/platform/network_info.dart';
import 'package:rick_and_morty_app/data/data_sources/person_local_data_source.dart';
import 'package:rick_and_morty_app/data/data_sources/person_remote_data_sourse.dart';
import 'package:rick_and_morty_app/data/models/person_model.dart';
import 'package:rick_and_morty_app/domain/entities/persone_entity.dart';
import 'package:rick_and_morty_app/domain/repository/persone_repository.dart';

/*  */

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remouteDataSource;
  final PersonLocalDataSources localDataSources;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remouteDataSource,
    required this.localDataSources,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPesons(
      () {
        return remouteDataSource.getAllPersones(page);
      },
    );
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPesons(
      () {
        return localDataSources.getLastPersonsFromCashe();
      },
    );
  }

  /* Реалізація приватного методу для отримання даних з перевіркою підключення інтернету. 
  При наявності підключення до інтернету дані тягнуться з сервера (remoteDataSources), а при відсутньому інтернету 
  дані тяшнуться з кешу (localDataSources)
  */
  Future<Either<Failure, List<PersonModel>>> _getPesons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSources.personsToCashe(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationPerson = await localDataSources.getLastPersonsFromCashe();
        return Right(locationPerson);
      } on CasheException {
        return Left(CasheFailure());
      }
    }
  }
}
