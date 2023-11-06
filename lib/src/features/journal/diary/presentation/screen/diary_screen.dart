import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/journal/diary/presentation/bloc/bloc/diary_bloc.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/widgets/diary_card.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  static const String routeName = 'diary/';

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  late DiaryBloc diaryBloc;
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
        title: 'Diaries',
        backgroundColor: const Color(0xFFEBD9C4),
      ),
      body: BlocBuilder<DiaryBloc, DiaryState>(
        bloc: diaryBloc,
        builder: (context, state) {
          final diaries = state.diaryResponseModel.diaries;

          if (state.viewStatus == ViewStatus.failed) {
            return const Center(
              child: CustomText(text: 'Something went wrong'),
            );
          }

          if (state.diaryResponseModel.count == 0) {
            return const Center(
              child: CustomText(text: 'No diary found.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1), () {
                  pullToRefresh();
                });
              },
              child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: diaries.length + 1,
                itemBuilder: (context, index) {
                  if (index < diaries.length) {
                    final item = diaries[index];

                    return DiaryCard(diary: item);
                  } else {
                    if (state.diaryResponseModel.nextPage != null) {
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
        },
      ),
    );
  }

  void handleSetBloc() {
    diaryBloc = BlocProvider.of<DiaryBloc>(context);
  }

  void scrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.maxScrollExtent * 0.75)) {
        diaryBloc.add(PaginateDiaryEvent());
      }
    });
  }

  void pullToRefresh() {
    diaryBloc.add(GetDiaryEvent());
  }
}
