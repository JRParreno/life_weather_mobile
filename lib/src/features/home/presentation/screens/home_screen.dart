import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/gen/colors.gen.dart';
import 'package:life_weather_mobile/src/core/bloc/view_status.dart';
import 'package:life_weather_mobile/src/core/utils/profile_utils.dart';
import 'package:life_weather_mobile/src/core/utils/spacing/v_space.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/home/presentation/bloc/bloc/bottom_navigation_bloc.dart';
import 'package:life_weather_mobile/src/features/home/presentation/body/home_header.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/body/journal_diary_body.dart';
import 'package:life_weather_mobile/src/features/journal/presentation/body/journal_todo_body.dart';
import 'package:life_weather_mobile/src/features/journal/todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/bloc/bloc/weather_bloc.dart';
import 'package:life_weather_mobile/src/features/weather/presentation/body/current_weather_v2.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TodoBloc todoBloc;
  late WeatherBloc weatherBloc;

  @override
  void initState() {
    handleSetBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context, titleWidget: const HomeHeader(), showBackBtn: true),
      body: SafeArea(
        child: Container(
          color: ColorName.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      BlocBuilder<WeatherBloc, WeatherState>(
                        bloc: weatherBloc,
                        builder: (context, state) {
                          if (state.viewStatus == ViewStatus.loading) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 25,
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.all(15),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          if (state.currentWeather != null) {
                            return GestureDetector(
                              onTap: () {
                                handleUpdateBottomNav(1);
                              },
                              child: CurrentWeatherV2(
                                weather: state.currentWeather!,
                              ),
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                      Vspace.md,
                      JournalDiaryBody(bloc: todoBloc),
                      Vspace.md,
                      JournalTodoBody(bloc: todoBloc),
                      Vspace.md,
                      CustomBtn(
                        label: 'Logout',
                        onTap: () {
                          handleLogout(context);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleLogout(BuildContext ctx) {
    ProfileUtils.handleLogout(ctx);
  }

  void handleSetBloc() {
    todoBloc = BlocProvider.of<TodoBloc>(context);
    weatherBloc = BlocProvider.of<WeatherBloc>(context);

    weatherBloc.add(const GetCurrentWeatherEvent(
        latitude: 13.582336, longitude: 123.2928768));
    todoBloc.add(const TodoGetEventList());
  }

  void handleUpdateBottomNav(int index) {
    BlocProvider.of<BottomNavigationBloc>(context)
        .add(UpdateBottomNavEvent(index));
  }
}
