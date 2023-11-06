import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_state.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/bloc/bloc/diary_bloc.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/bloc/bloc/todo_bloc.dart';

class DiaryAddScreen extends StatefulWidget {
  const DiaryAddScreen({
    super.key,
  });

  static const String routeName = 'diary/add';

  @override
  State<DiaryAddScreen> createState() => _DiaryAddScreenState();
}

class _DiaryAddScreenState extends State<DiaryAddScreen> {
  final TextEditingController titleCtrl = TextEditingController();

  final formKey = GlobalKey<FormState>();
  late final DiaryBloc diaryBloc;

  @override
  void initState() {
    diaryBloc = BlocProvider.of<DiaryBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiaryBloc, DiaryState>(
      bloc: diaryBloc,
      listener: (context, state) {
        if (state.viewStatus == ViewStatus.loading) {
          LoaderDialog.show(context: context);
        }
        if (state.viewStatus == ViewStatus.successful) {
          formKey.currentState!.reset();
          titleCtrl.text = '';

          LoaderDialog.hide(context: context);

          Future.delayed(const Duration(seconds: 1), () {
            handleSnackBar();
          });
        }

        if (state is ErrorState) {
          LoaderDialog.hide(context: context);
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xFFB9DFE3),
          appBar: buildAppBar(context: context, title: 'Add Diary'),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Please enter the title first',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Vspace.md,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          text:
                              'Date: ${formattedDate(DateTime.now().toString())}',
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
                        CustomBtn(
                          label: 'Submit',
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            handleSubmitForm();
                          },
                        ),
                      ],
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

  String formattedDate(String dateCreated) {
    final f = DateFormat('MMM dd, yyyy');

    return f.format(DateTime.parse(dateCreated));
  }

  void handleSubmitForm() {
    if (formKey.currentState!.validate()) {
      diaryBloc.add(
        AddDiaryEvent(
          titleCtrl.value.text,
        ),
      );
    }
  }

  void handleSnackBar() {
    final snackBar = SnackBar(
      content: const CustomText(text: 'Successfully added diary'),
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
