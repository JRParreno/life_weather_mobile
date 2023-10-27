import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/widgets/journal_body_container.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/widgets/todo_card.dart';

class JournalTodoBody extends StatelessWidget {
  const JournalTodoBody({super.key, required this.bloc});

  final TodoBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is TodoLoaded) {
          final isEmpty = state.todoResponseModel.todos.isEmpty;

          return JournalBodyContainer(
            backgroundColor: const Color(0xFFB9DFE3),
            isEmpty: isEmpty,
            headerTitle: 'Todos',
            content: isEmpty
                ? Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Center(
                        child: CustomBtn(
                          label: 'Tap here to add Todo',
                          onTap: () {},
                          unsetWidth: true,
                          backgroundColor: const Color(0xFF632F57),
                        ),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.todoResponseModel.count > 4
                            ? 4
                            : state.todoResponseModel.count,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = state.todoResponseModel.todos[index];

                          return TodoCard(todoModel: item);
                        },
                      ),
                      Vspace.xs,
                      CustomBtn(
                        label: 'Add Todo',
                        onTap: () {},
                        unsetWidth: true,
                      ),
                      Vspace.xs,
                    ],
                  ),
          );
        }

        return JournalBodyContainer(
          backgroundColor: const Color(0xFFB9DFE3),
          isEmpty: true,
          headerTitle: 'Todos',
          content: Flexible(
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 20,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
