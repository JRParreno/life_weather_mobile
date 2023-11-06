import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_state.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/screens/todo_add_update_screen.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/widgets/todo_card.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  static const String routeName = 'todos/';

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoBloc todoBloc;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    handleSetBloc();
    scrollListener();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 40,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: 'Todos',
        backgroundColor: const Color(0xFFB9DFE3),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        bloc: todoBloc,
        builder: (context, state) {
          if (state is TodoLoaded) {
            final todos = state.todoResponseModel.todos;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1), () {
                    // pullToRefresh();
                  });
                },
                child: ListView.builder(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: todos.length + 1,
                  itemBuilder: (context, index) {
                    if (index < todos.length) {
                      final item = todos[index];

                      return TodoCard(
                        todoModel: item,
                      );
                    } else {
                      if (state.todoResponseModel.hasNextPage) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return const SizedBox();
                    }
                  },
                ),
              ),
            );
          }

          if (state is ErrorState) {
            return const Center(
              child: CustomText(text: 'Something went wrong'),
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            TodoAddUpdateScreen.routeName,
            arguments: const TodoAddUpdateArgs(null),
          );
        },
        backgroundColor: ColorName.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  void handleSetBloc() {
    todoBloc = BlocProvider.of<TodoBloc>(context);
  }

  void scrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.maxScrollExtent * 0.75)) {
        todoBloc.add(PaginateTodoEvent());
      }
    });
  }
}
