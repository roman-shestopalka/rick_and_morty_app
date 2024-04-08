import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:rick_and_morty_app/domain/entities/persone_entity.dart';
import 'package:rick_and_morty_app/domain/use_cases/get_all_persons.dart';
import 'package:rick_and_morty_app/presentation/bloc/person_list_cubit/person_list_state.dart';

const serverFailureMessage = "Server Failure";
const ceshedFailureMessage = "Cashe Failure";

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());

  void loadPerson() async {
    final currentState = state;
    var oldPerson = <PersonEntity>[];
    int page = 1;
    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    if (state is PersonLoading) return;

    if (currentState is PersonLoaded) {
      oldPerson = currentState.personsList;
    }

    emit(PersonLoading(
      oldPerson,
      isPersonFetch: page == 1,
    ));

    failureOrPerson.fold(
        (error) => emit(PersonError(message: _mapFailureToMessage(error))),
        (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons.addAll(character);
      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return serverFailureMessage;
      case const (CasheFailure):
        return ceshedFailureMessage;
      default:
        return "Unexpected Error";
    }
  }
}
