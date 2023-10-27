import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/utils/profile_utils.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/features/home/presentation/body/home_header.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/body/journal_diary_body.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/body/journal_todo_body.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/bloc/bloc/todo_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TodoBloc todoBloc;

  @override
  void initState() {
    handleSetBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ColorName.white,
          child: Column(
            children: [
              const HomeHeader(),
              Vspace.md,
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    JournalDiaryBody(bloc: todoBloc),
                    Vspace.md,
                    JournalTodoBody(bloc: todoBloc)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleLogout(BuildContext ctx) {
    ProfileUtils.handleLogout(ctx);
  }

  void handleSetBloc() {
    todoBloc = BlocProvider.of<TodoBloc>(context);

    todoBloc.add(const TodoGetEventList());
  }
}
