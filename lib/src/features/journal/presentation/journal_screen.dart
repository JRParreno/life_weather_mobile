import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/custom_appbar.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/bloc/bloc/diary_bloc.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/body/journal_diary_body.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/body/journal_todo_body.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/bloc/bloc/todo_bloc.dart';

class JournalScreen extends StatefulWidget {
  static const String routeName = 'journal/';
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  late TodoBloc todoBloc;
  late DiaryBloc diaryBloc;

  @override
  void initState() {
    handleSetBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          buildAppBar(context: context, showBackBtn: true, title: "Journal"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              JournalDiaryBody(bloc: diaryBloc),
              Vspace.md,
              JournalTodoBody(bloc: todoBloc)
            ],
          ),
        ),
      ),
    );
  }

  void handleSetBloc() {
    todoBloc = BlocProvider.of<TodoBloc>(context);
    diaryBloc = BlocProvider.of<DiaryBloc>(context);

    todoBloc.add(const TodoGetEventList());
    diaryBloc.add(GetDiaryEvent());
  }
}
