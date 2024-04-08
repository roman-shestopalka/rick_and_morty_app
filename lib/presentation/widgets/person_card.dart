import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/domain/entities/persone_entity.dart';
import 'package:rick_and_morty_app/presentation/common/app_colors.dart';
import 'package:rick_and_morty_app/presentation/pages/person_detail_screen/person_detail_screen.dart';
import 'package:rick_and_morty_app/presentation/widgets/person_cache_image.dart';

class PersonCardWidget extends StatelessWidget {
  final PersonEntity person;
  const PersonCardWidget({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PersonDetailPage(person: person),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            PersonCacheWidget(
              imageUrl: person.image,
              width: 160,
              height: 160,
            ),
            const SizedBox(width: 15),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  person.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      person.status,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: person.status == "Alive"
                              ? Colors.green
                              : Colors.red,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      " - ${person.species}",
                      maxLines: 1,
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Last know location:",
                  style: TextStyle(
                    color: AppColors.greyColor,
                  ),
                ),
                Text(
                  person.location,
                  maxLines: 1,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Last know location:",
                  style: TextStyle(
                    color: AppColors.greyColor,
                  ),
                ),
                Text(
                  person.origin,
                  maxLines: 1,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
