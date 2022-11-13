import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_card_widget.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: const SafeArea(
          child: PersonList(),
        ),
      );

  _buildAppBar() => AppBar(
        title: const Text('Characters'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: AppColors.white,
          )
        ],
      );
}

class PersonList extends StatelessWidget {
  const PersonList({super.key});

  @override
  Widget build(BuildContext context) {
    List<PersonEntity> persons = [];
    return BlocBuilder<PersonListCubit, PersonListState>(
      builder: (context, state) {
        if (state is PersonLoadingState && state.isFirstFetch) {
          return _loadingIndicator();
        }
        if (state is PersonLoadedState) {
          persons = state.personList;
        }
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: persons.length,
          itemBuilder: (context, index) => PersonCard(person: persons[index]),
          separatorBuilder: (context, index) => const Divider(
            color: AppColors.cellBackground,
          ),
        );
      },
    );
  }

  Widget _loadingIndicator() => const Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        ),
      );
}
