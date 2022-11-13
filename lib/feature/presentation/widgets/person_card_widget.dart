import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({Key? key, required this.person}) : super(key: key);

  final PersonEntity person;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cellBackground,
        borderRadius: BorderRadius.circular(8), //побаловаться
      ),
      child: Row(
        children: [
          _buildImage(),
          _buildPersonInfo(),
        ],
      ),
    );
  }

  Widget _buildImage() => ClipRRect(
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
        child: Image.network(
          person.image,
          width: 160,
          height: 160,
        ),
      );

  Widget _buildPersonInfo() => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildName(),
              const SizedBox(height: 4),
              _buildStatus(),
              const SizedBox(width: 12),
              _buildInfo(
                title: 'Last known location:',
                info: person.location?.name ?? '',
              ),
              const SizedBox(width: 12),
              _buildInfo(
                title: 'First seen in:',
                info: person.origin?.name ?? '',
              ),
            ],
          ),
        ),
      );

  Widget _buildName() => Text(
        person.name,
        style: const TextStyle(
          fontSize: 20,
          color: AppColors.white,
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _buildStatus() => Row(
        children: [
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: person.status == 'Alive' ? AppColors.alive : AppColors.dead,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${person.status} - ${person.species}',
            style: const TextStyle(color: AppColors.white),
            maxLines: 1,
          ),
        ],
      );

  Widget _buildInfo({required String title, required String info}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: AppColors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            info,
            style: const TextStyle(color: AppColors.white),
          ),
        ],
      );
}
