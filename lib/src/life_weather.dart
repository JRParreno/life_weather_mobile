import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_event.dart';
import 'package:life_weather_mobile/src/core/bloc/common/common_state.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/core/local_storage/local_storage.dart';
import 'package:life_weather_mobile/src/core/routes/routes.dart';
import 'package:life_weather_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/models/profile_model.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/repositories/profile_repository_impl.dart';
import 'package:life_weather_mobile/src/features/home/presentation/screens/home_navigation.dart';
import 'package:life_weather_mobile/src/features/home/presentation/screens/home_screen.dart';

class LifeWeather extends StatefulWidget {
  const LifeWeather({super.key});
  static final navKey = GlobalKey<NavigatorState>();

  @override
  State<LifeWeather> createState() => _LifeWeatherState();
}

class _LifeWeatherState extends State<LifeWeather> {
  void initialization(BuildContext ctx) async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    final user = await LocalStorage.readLocalStorage('_user');
    if (user != null) {
      final userProfile = await ProfileRepositoryImpl().fetchProfile();
      // ignore: use_build_context_synchronously
      setProfileBloc(profile: userProfile, ctx: ctx);
    } else {
      await LocalStorage.deleteLocalStorage('_user');
      await LocalStorage.deleteLocalStorage('_refreshToken');
      await LocalStorage.deleteLocalStorage('_token');
      // ignore: use_build_context_synchronously
      setProfileBloc(profile: null, ctx: ctx);
    }
    // Future.delayed(const Duration(seconds: 2), () {
    //   FlutterNativeSplash.remove();
    // });
  }

  void setProfileBloc({
    ProfileModel? profile,
    required BuildContext ctx,
  }) {
    if (profile != null) {
      BlocProvider.of<ProfileBloc>(ctx).add(
        SetProfileEvent(profile: profile),
      );
    } else {
      BlocProvider.of<ProfileBloc>(ctx).add(
        const InitialEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => ProfileBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        builder: ((context, child) {
          return MaterialApp(
            navigatorKey: LifeWeather.navKey,
            builder: EasyLoading.init(),
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: generateRoute,
            home: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (ctx, state) {
                if (state is InitialState) {
                  initialization(ctx);
                }

                if (state is ProfileLoaded) {
                  return const HomeNavigation();
                } else {
                  return const LoginScreen();
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
