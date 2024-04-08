import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty_app/core/platform/network_info.dart';
import 'package:rick_and_morty_app/data/data_sources/person_local_data_source.dart';
import 'package:rick_and_morty_app/data/data_sources/person_remote_data_sourse.dart';
import 'package:rick_and_morty_app/data/repositories/person_repository_impl.dart';
import 'package:rick_and_morty_app/domain/repository/persone_repository.dart';
import 'package:rick_and_morty_app/domain/use_cases/get_all_persons.dart';
import 'package:rick_and_morty_app/domain/use_cases/search_person.dart';
import 'package:rick_and_morty_app/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_app/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //BLoC / Cubit
  sl.registerFactory(
    () => PersonListCubit(getAllPersons: sl()),
  );
  sl.registerFactory(
    () => PersonSearchBloc(searchPerson: sl()),
  );

  //UseCases
  sl.registerLazySingleton(
    () => GetAllPersons(sl()),
  );
  sl.registerLazySingleton(
    () => SearchPerson(sl()),
  );
  //Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
        remouteDataSource: sl(),
        localDataSources: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<PersonRemoteDataSource>(
    () => PersonRemouteDataSourceImpl(client: http.Client()),
  );
  sl.registerLazySingleton<PersonLocalDataSources>(
    () => PersonLocalDataSourcesImpl(sharedPreferences: sl()),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(
    () => http.Client(),
  );
  sl.registerLazySingleton(
    () => InternetConnectionChecker(),
  );
}
