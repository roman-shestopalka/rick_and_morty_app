import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_app/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_app/presentation/common/app_colors.dart';
import 'package:rick_and_morty_app/presentation/pages/main/main_screen.dart';
import 'package:rick_and_morty_app/service_locator.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
            create: (context) => sl<PersonListCubit>()..loadPerson()),
        BlocProvider<PersonSearchBloc>(
            create: (context) => sl<PersonSearchBloc>()),
      ],
      child: MaterialApp(
        title: 'Rick and Morty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            background: AppColors.backgroundColor,
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
