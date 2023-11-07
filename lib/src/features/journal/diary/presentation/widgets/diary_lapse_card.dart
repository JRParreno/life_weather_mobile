import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary_lapse.dart';

class DiaryLapseCard extends StatelessWidget {
  const DiaryLapseCard({super.key, required this.diaryLapse});

  final DiaryLapse diaryLapse;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: formattedDate(diaryLapse.dateCreated),
            style: textTheme.labelLarge!.apply(color: ColorName.placeHolder),
          ),
          Vspace.xs,
          Container(
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: ColorName.placeHolder,
                  width: 5,
                ),
              ),
            ),
            margin: const EdgeInsets.only(left: 4),
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ColorName.placeHolder, width: 2),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              child: CustomText(
                text: diaryLapse.note,
                style: textTheme.labelLarge!.apply(color: ColorName.text),
              ),
            ),
          ),
          Vspace.md,
        ],
      ),
    );
  }

  String formattedDate(String dateCreated) {
    final f = DateFormat.jm();

    return f.format(DateTime.parse(dateCreated));
  }
}
