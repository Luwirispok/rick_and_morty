import 'dart:developer';

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
        body: SafeArea(
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
  PersonList({super.key});

  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<PersonListCubit>().loadPersonCubit();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    List<PersonEntity> persons = [];

    bool isLoading = false;

    return BlocBuilder<PersonListCubit, PersonListState>(
      builder: (context, state) {
        if (state is PersonLoadingState && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PersonLoadingState) {
          persons = state.oldPersonList;
          isLoading = true;
        } else if (state is PersonLoadedState) {
          persons = state.personList;
        } else if (state is PersonErrorState) {
          log(state.message);
          return _buildError(state.message);
        }
        return ListView.separated(
          controller: scrollController,
          padding: const EdgeInsets.all(8),
          itemCount: persons.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < persons.length) {
              return PersonCard(person: persons[index]);
            } else {
              // Timer(const Duration(seconds: 1), () {
              //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
              // });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) => const Divider(
            color: AppColors.cellBackground,
          ),
        );
      },
    );
  }

  Widget _loadingIndicator() => const Center(
        child: CircularProgressIndicator(
          color: AppColors.white,
        ),
      );

  Widget _buildError(String text) => Text(
        text,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 25,
        ),
      );
}
