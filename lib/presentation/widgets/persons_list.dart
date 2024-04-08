import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/domain/entities/persone_entity.dart';
import 'package:rick_and_morty_app/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_app/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty_app/presentation/common/app_colors.dart';
import 'package:rick_and_morty_app/presentation/widgets/person_card.dart';

class PersonsListWidget extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        context.read<PersonListCubit>().loadPerson();
      }
    });
  }

  PersonsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    bool isLoading = false;
    List<PersonEntity> persons = [];

    return BlocBuilder<PersonListCubit, PersonState>(
      builder: (context, state) {
        if (state is PersonLoading && state.isPersonFetch) {
          return _loadingIndicator();
        }
        if (state is PersonLoading) {
          persons = state.oldPersonsList;
          isLoading = true;
        } else if (state is PersonLoaded) {
          persons = state.personsList;
        } else if (state is PersonError) {
          Text(
            state.message,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 27,
            ),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCardWidget(
                person: persons[index],
              );
            } else {
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: AppColors.greyColor,
            );
          },
          itemCount: persons.length + (isLoading ? 1 : 0),
        );
      },
    );
  }
}

Widget _loadingIndicator() {
  return const Padding(
    padding: EdgeInsets.all(8.0),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
