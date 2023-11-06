import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_state.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/todo/data/models/todo_model.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/widgets/delete_dialog.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/widgets/status_select.dart';

class TodoAddUpdateArgs {
  final TodoModel? todoModel;

  const TodoAddUpdateArgs(this.todoModel);
}

class TodoAddUpdateScreen extends StatefulWidget {
  const TodoAddUpdateScreen({
    super.key,
    required this.args,
  });

  static const String routeName = 'todo/add-update';

  final TodoAddUpdateArgs args;

  @override
  State<TodoAddUpdateScreen> createState() => _TodoAddUpdateScreenState();
}

class _TodoAddUpdateScreenState extends State<TodoAddUpdateScreen> {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController noteCtrl = TextEditingController();
  final TextEditingController statusCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  late final TodoBloc todoBloc;

  @override
  void initState() {
    todoBloc = BlocProvider.of<TodoBloc>(context);
    handleInitForm(widget.args.todoModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      bloc: todoBloc,
      listener: (context, state) {
        if (state is TodoLoaded) {
          if (state.viewStatus == ViewStatus.loading) {
            LoaderDialog.show(context: context);
          }
          if (state.viewStatus == ViewStatus.successful) {
            if (widget.args.todoModel == null) {
              formKey.currentState!.reset();
              titleCtrl.text = '';
              noteCtrl.text = '';
            }

            LoaderDialog.hide(context: context);

            if (state.isDeleteTodo) {
              Navigator.pop(context);
            } else {
              Future.delayed(const Duration(seconds: 1), () {
                handleSnackBar();
              });
            }
          }
        }

        if (state is ErrorState) {
          LoaderDialog.hide(context: context);
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xFFB9DFE3),
          appBar: buildAppBar(
            context: context,
            title: '${widget.args.todoModel != null ? 'Update' : 'Add'} Todo',
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
            backgroundColor: const Color(0xFFB9DFE3),
            isDarkMode: false,
            elevation: 1,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                decoration: BoxDecoration(
                    color: ColorName.white,
                    borderRadius: BorderRadius.circular(5)),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: 'Date: ${formattedDate(DateTime.now().toString())}',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: ColorName.placeHolder),
                    ),
                    Vspace.sm,
                    CustomTextField(
                      textController: titleCtrl,
                      labelText: "Title",
                      keyboardType: TextInputType.text,
                      padding: EdgeInsets.zero,
                      parametersValidate: 'required',
                    ),
                    Vspace.xs,
                    CustomTextField(
                      textController: noteCtrl,
                      labelText: "Note",
                      keyboardType: TextInputType.multiline,
                      padding: EdgeInsets.zero,
                      parametersValidate: 'required',
                      maxLines: 5,
                      minLines: 3,
                    ),
                    Vspace.sm,
                    CustomTextField(
                      focus: false,
                      textController: statusCtrl,
                      labelText: "Status",
                      padding: EdgeInsets.zero,
                      parametersValidate: 'required',
                      readOnly: true,
                      onTap: () => commonBottomSheetDialog(
                        context: context,
                        height: 320,
                        title: "Select Status",
                        container: StatusSelectWidget(
                          onSelectStatus: (String value) {
                            statusCtrl.value = TextEditingController.fromValue(
                                    TextEditingValue(text: value))
                                .value;
                          },
                          selectedStatus: statusCtrl.text.isNotEmpty
                              ? statusCtrl.text
                              : null,
                        ),
                      ),
                    ),
                    Vspace.sm,
                    if (widget.args.todoModel != null) ...[
                      DeleteDialog(
                        title: widget.args.todoModel!.title,
                        onTapOk: () {
                          FocusManager.instance.primaryFocus?.unfocus();

                          Navigator.pop(context);

                          Future.delayed(const Duration(milliseconds: 500), () {
                            handleDeleteTodo(
                                widget.args.todoModel!.pk.toString());
                          });
                        },
                      ),
                      Vspace.sm,
                    ],
                    CustomBtn(
                      label:
                          widget.args.todoModel != null ? "Update" : "Submit",
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        handleSubmitForm();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleInitForm(TodoModel? todoModel) {
    if (todoModel != null) {
      titleCtrl.text = todoModel.title;
      noteCtrl.text = todoModel.note;
      statusCtrl.text = todoModel.status;
      return;
    }

    statusCtrl.text = 'TODO';
  }

  String formattedDate(String dateCreated) {
    final f = DateFormat('MMM dd, yyyy');

    return f.format(DateTime.parse(dateCreated));
  }

  void handleSubmitForm() {
    final todoModel = widget.args.todoModel;

    if (formKey.currentState!.validate()) {
      if (todoModel != null) {
        todoBloc.add(
          UpdateTodoEvent(
            title: titleCtrl.value.text,
            note: noteCtrl.value.text,
            status: statusCtrl.value.text,
            id: todoModel.pk.toString(),
          ),
        );
        return;
      }

      todoBloc.add(
        AddTodoEvent(
          title: titleCtrl.value.text,
          note: noteCtrl.value.text,
          status: statusCtrl.value.text,
        ),
      );
    }
  }

  void handleDeleteTodo(String pk) {
    todoBloc.add(
      DeleteTodoEvent(pk),
    );
  }

  void handleSnackBar() {
    final text = widget.args.todoModel != null
        ? "Successfully update your todo"
        : "Successfully added todo";

    final snackBar = SnackBar(
      content: CustomText(text: text),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
