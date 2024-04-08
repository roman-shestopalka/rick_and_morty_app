import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/widgets/custom_search_delegate.dart';
import 'package:rick_and_morty_app/presentation/widgets/persons_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          )
        ],
      ),
      body: PersonsListWidget(),
    );
  }
}
