import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/widgets/journal_body_container.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/screens/todo_add_update_screen.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/screens/todo_screen.dart';
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
          final todos = state.todoResponseModel.todos;
          final isEmpty = todos.isEmpty;

          return JournalBodyContainer(
            backgroundColor: const Color(0xFFB9DFE3),
            isEmpty: isEmpty,
            isShowViewAll: todos.length > 3,
            routeName: TodoScreen.routeName,
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
                          onTap: () {
                            handleOntap(context);
                          },
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
                        itemCount: state.todoResponseModel.count > 3
                            ? 3
                            : state.todoResponseModel.count,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = state.todoResponseModel.todos[index];

                          return TodoCard(
                            todoModel: item,
                            isList: false,
                          );
                        },
                      ),
                      Vspace.xs,
                      CustomBtn(
                        label: 'Add Todo',
                        onTap: () {
                          handleOntap(context);
                        },
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

  void handleOntap(BuildContext context) {
    Navigator.of(context).pushNamed(
      TodoAddUpdateScreen.routeName,
      arguments: const TodoAddUpdateArgs(null),
    );
  }
}
