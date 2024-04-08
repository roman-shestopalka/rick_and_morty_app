import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/entities/persone_entity.dart';

class SearchResult extends StatelessWidget {
  final PersonEntity personResult;
  const SearchResult({super.key, required this.personResult});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3.0,
      child: Column(
        children: [
          Text(
            personResult.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
