import 'package:flutter/material.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/widgets/journal_body_container.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/bloc/bloc/todo_bloc.dart';

class JournalDiaryBody extends StatelessWidget {
  const JournalDiaryBody({super.key, required this.bloc});

  final TodoBloc bloc;

  @override
  Widget build(BuildContext context) {
    return JournalBodyContainer(
      backgroundColor: const Color(0xFFEBD9C4),
      isEmpty: true,
      headerTitle: 'Diaries',
      content: Flexible(
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          child: Center(
            child: CustomBtn(
              label: 'Tap here to add Diary',
              onTap: () {},
              unsetWidth: true,
              backgroundColor: const Color(0xFF7B5B5C),
            ),
          ),
        ),
      ),
    );
  }
}
