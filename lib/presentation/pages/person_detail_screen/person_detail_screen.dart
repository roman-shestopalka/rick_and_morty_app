import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/entities/persone_entity.dart';
import 'package:rick_and_morty_app/presentation/common/app_colors.dart';
import 'package:rick_and_morty_app/presentation/widgets/person_cache_image.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;
  const PersonDetailPage({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                person.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: PersonCacheWidget(
                  imageUrl: person.image,
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PersonStatusWidget(person: person),
                  const SizedBox(width: 10),
                  Text(
                    person.status,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              CustomFields(
                title: "Gender:",
                description: person.gender,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomFields(
                title: "Number of episods:",
                description: person.episode.length.toString(),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomFields(
                title: "Species:",
                description: person.species,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomFields(
                title: "Last know location:",
                description: person.location,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomFields(
                title: "Origin:",
                description: person.origin,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomFields(
                title: "Was created:",
                description: person.created.toString(),
              ),
              if (person.type.isNotEmpty)
                CustomFields(title: "Type:", description: person.type),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomFields extends StatelessWidget {
  final String title;
  final String description;

  const CustomFields({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          maxLines: 2,
          style: const TextStyle(
            fontSize: 18,
            color: AppColors.greyColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class PersonStatusWidget extends StatelessWidget {
  const PersonStatusWidget({
    super.key,
    required this.person,
  });

  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: person.status == "Alive" ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
