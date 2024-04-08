import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/domain/entities/persone_entity.dart';
import 'package:rick_and_morty_app/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_app/presentation/common/app_colors.dart';
import 'package:rick_and_morty_app/presentation/widgets/search_result.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: "Search for characters...");
  final _suggestions = [
    "Rick",
    "Morty",
    "Summer",
    "Beth",
    "Jerry",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear_outlined),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_outlined),
      tooltip: "Back",
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<PersonSearchBloc>(
      context,
      listen: false,
    ).add(SearchPersons(query));

    return BlocBuilder<PersonSearchBloc, PersonSearchState>(
        builder: (context, state) {
      if (state is PersonSearchLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is PersonSearchLoaded) {
        final person = state.persons;
        if (person.isEmpty) {
          return _showErrorText("No characters with that name found");
        }
        return SizedBox(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              PersonEntity result = person[index];
              return SearchResult(personResult: result);
            },
            itemCount: person.isNotEmpty ? person.length : 0,
          ),
        );
      } else if (state is PersonSearchError) {
        return _showErrorText(state.message);
      } else {
        return const Icon(Icons.no_accounts);
      }
    });
  }

  Widget _showErrorText(String errorMessage) {
    return Container(
      color: Colors.black,
      child: Text(
        errorMessage,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      return Container();
    }
    return ListView.separated(
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.all(7),
          child: Text(
            _suggestions[index],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      }),
      separatorBuilder: ((context, index) {
        return const Divider(
          color: AppColors.greyColor,
        );
      }),
      itemCount: _suggestions.length,
    );
  }
}
