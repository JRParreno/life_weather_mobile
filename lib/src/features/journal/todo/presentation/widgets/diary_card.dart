import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/diary/data/models/diary.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/screen/diary_detail_screen.dart';

class DiaryCard extends StatelessWidget {
  const DiaryCard({
    Key? key,
    required this.diary,
  }) : super(key: key);

  final Diary diary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        handleOntap(
          diary: diary,
          context: context,
        );
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: diary.title,
                    style: textTheme.titleLarge,
                  ),
                  Vspace.xs,
                  CustomText(
                    text: formattedDate(
                      diary.dateCreated,
                    ),
                    style: textTheme.labelSmall,
                  )
                ],
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formattedDate(String dateCreated) {
    final f = DateFormat('MMM dd, yyyy hh:mm');

    return f.format(DateTime.parse(dateCreated));
  }

  void handleOntap({
    required Diary diary,
    required BuildContext context,
  }) {
    Navigator.of(context).pushNamed(
      DiaryDetailScreen.routeName,
      arguments: DiaryDetailArgs(diary),
    );
  }
}
