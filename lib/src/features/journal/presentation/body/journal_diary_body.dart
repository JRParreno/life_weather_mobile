import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/bloc/bloc/diary_bloc.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/widgets/journal_body_container.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/widgets/diary_card.dart';

class JournalDiaryBody extends StatelessWidget {
  const JournalDiaryBody({super.key, required this.bloc});

  final DiaryBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiaryBloc, DiaryState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.viewStatus == ViewStatus.successful) {
          return bodyContainer(
            state.diaryResponseModel.diaries.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.diaryResponseModel.count > 3
                            ? 3
                            : state.diaryResponseModel.count,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = state.diaryResponseModel.diaries[index];

                          return DiaryCard(diary: item);
                        },
                      ),
                      Vspace.xs,
                      CustomBtn(
                        label: 'Add Diary',
                        onTap: () {
                          // handleOntap(context);
                        },
                        unsetWidth: true,
                      ),
                      Vspace.xs,
                    ],
                  )
                : CustomBtn(
                    label: 'Tap here to add Diary',
                    onTap: () {},
                    unsetWidth: true,
                    backgroundColor: const Color(0xFF7B5B5C),
                  ),
          );
        }

        return bodyContainer(const Center(
          child: CircularProgressIndicator(),
        ));
      },
    );
  }

  Widget bodyContainer(Widget child) {
    return JournalBodyContainer(
      backgroundColor: const Color(0xFFEBD9C4),
      isEmpty: true,
      headerTitle: 'Diaries',
      content: Flexible(
        child: Container(
          margin: const EdgeInsets.only(
            bottom: 20,
          ),
          child: child,
        ),
      ),
    );
  }
}
