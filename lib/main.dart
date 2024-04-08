import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/app/rick_and_morty_app.dart';
import 'package:rick_and_morty_app/service_locator.dart' as di;

//make this method async for registration all of libraries in DI
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const RickAndMortyApp());
}
