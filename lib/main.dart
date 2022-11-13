import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/di/injection.dart';
import 'package:rick_and_morty/feature/presentation/app.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/feature/presentation/bloc/person_search_bloc/person_search_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locator.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
          create: (context) => Locator.injection<PersonListCubit>()..loadPersonCubit(),
        ),
        BlocProvider<PersonSearchBloc>(
          create: (context) => Locator.injection<PersonSearchBloc>(),
        ),
      ],
      child: const App(),
    ),
  );
}