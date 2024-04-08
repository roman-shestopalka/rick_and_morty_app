part of 'search_bloc.dart';

sealed class PersonSearchState extends Equatable {
  const PersonSearchState();

  @override
  List<Object> get props => [];
}

final class SearchBlocInitial extends PersonSearchState {}

final class PersonEmpty extends PersonSearchState {}

final class PersonSearchLoading extends PersonSearchState {}

final class PersonSearchLoaded extends PersonSearchState {
  final List<PersonEntity> persons;

  const PersonSearchLoaded({required this.persons});

  @override
  List<Object> get props => [persons];
}

final class PersonSearchError extends PersonSearchState {
  final String message;

  const PersonSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
