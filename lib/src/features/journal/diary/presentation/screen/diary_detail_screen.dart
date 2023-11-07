import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/extensions/datetime_ext.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/screen/diary_lapse_add_update_screen.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/widgets/diary_lapse_card.dart';

class DiaryDetailArgs {
  final Diary diary;

  const DiaryDetailArgs(this.diary);
}

class DiaryDetailScreen extends StatefulWidget {
  const DiaryDetailScreen({super.key, required this.args});

  static const String routeName = 'diary/detail';

  final DiaryDetailArgs args;

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  Diary diary = Diary.empty();

  @override
  void initState() {
    setState(() {
      diary = widget.args.diary;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
        title: 'Diary',
        backgroundColor: const Color(0xFFEBD9C4),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CustomText(
                  text: formattedDate(diary.dateCreated),
                  style:
                      textTheme.labelLarge!.apply(color: ColorName.placeHolder),
                ),
              ),
              CustomText(
                text: diary.title,
                style: textTheme.displaySmall!.apply(color: ColorName.text),
              ),
              const Divider(
                color: ColorName.placeHolder,
              ),
              Vspace.md,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: diary.lapses.length,
                itemBuilder: (context, index) {
                  final item = diary.lapses[index];

                  return DiaryLapseCard(diaryLapse: item);
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: DateTime.parse(widget.args.diary.dateCreated)
              .isSameDate(DateTime.now())
          ? FloatingActionButton(
              onPressed: () {
                handleAddDiaryLapse();
              },
              backgroundColor: ColorName.primary,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  String formattedDate(String dateCreated) {
    final f = DateFormat('MMM dd, yyyy');

    return f.format(DateTime.parse(dateCreated));
  }

  Future<void> handleAddDiaryLapse() async {
    final newDiary = await Navigator.of(context).pushNamed(
      DiaryLapseAddUpdateScreen.routeName,
      arguments: DiaryLapseAddUpdateArgs(pk: diary.pk, isFromDiary: true),
    ) as Diary?;

    if (newDiary != null) {
      setState(() {
        diary = newDiary;
      });
    }
  }
}
