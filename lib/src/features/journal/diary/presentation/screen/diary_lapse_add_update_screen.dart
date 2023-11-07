import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary_lapse.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/bloc/bloc/diary_bloc.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/screen/diary_detail_screen.dart';

class DiaryLapseAddUpdateArgs {
  DiaryLapseAddUpdateArgs({
    required this.pk,
    this.diaryLapse,
    this.isFromDiary = false,
  });

  final DiaryLapse? diaryLapse;
  final int pk;
  final bool isFromDiary;
}

class DiaryLapseAddUpdateScreen extends StatefulWidget {
  const DiaryLapseAddUpdateScreen({super.key, required this.args});

  static const String routeName = 'diary/lapse/add-update';
  final DiaryLapseAddUpdateArgs args;

  @override
  State<DiaryLapseAddUpdateScreen> createState() =>
      _DiaryLapseAddUpdateScreenState();
}

class _DiaryLapseAddUpdateScreenState extends State<DiaryLapseAddUpdateScreen> {
  final TextEditingController descriptionCtrl = TextEditingController();

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
          descriptionCtrl.text = '';

          LoaderDialog.hide(context: context);

          Future.delayed(const Duration(milliseconds: 500), () {
            handleSnackBar(state.diaryResponseModel.diaries.first);
          });
        }

        if (state.viewStatus == ViewStatus.failed) {
          LoaderDialog.hide(context: context);
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xFFB9DFE3),
          appBar: buildAppBar(
            context: context,
            title: 'Add Diary Description',
            backgroundColor: const Color(0xFFEBD9C4),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          textController: descriptionCtrl,
                          labelText: "Description",
                          keyboardType: TextInputType.multiline,
                          padding: EdgeInsets.zero,
                          parametersValidate: 'required',
                          maxLines: 20,
                          minLines: 5,
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
        AddDiaryLapseEvent(
          note: descriptionCtrl.value.text,
          pk: widget.args.pk,
        ),
      );
    }
  }

  void handleSnackBar(Diary diary) {
    if (widget.args.isFromDiary) {
      Navigator.of(context).pop(diary);
      return;
    }
    Navigator.of(context).pushReplacementNamed(
      DiaryDetailScreen.routeName,
      arguments: DiaryDetailArgs(diary),
    );
  }
}
