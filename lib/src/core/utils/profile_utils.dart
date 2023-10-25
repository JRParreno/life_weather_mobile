import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_weather_mobile/src/core/bloc/profile/profile_bloc.dart';
import 'package:life_weather_mobile/src/core/config/app_constant.dart';
import 'package:life_weather_mobile/src/core/local_storage/local_storage.dart';
import 'package:life_weather_mobile/src/core/widgets/common_widget.dart';
import 'package:life_weather_mobile/src/features/account/login/presentation/screen/login_screen.dart';
import 'package:life_weather_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:ndialog/ndialog.dart';

class ProfileUtils {
  static Profile? userProfile(BuildContext ctx) {
    final profileState = BlocProvider.of<ProfileBloc>(ctx).state;
    if (profileState is ProfileLoaded) {
      return profileState.profile;
    }
    return null;
  }

  static void handleLogout(BuildContext context) async {
    NDialog(
      dialogStyle: DialogStyle(titleDivider: true),
      title: const CustomText(text: AppConstant.appName),
      content: const CustomText(text: "Are you sure? you want to logout"),
      actions: <Widget>[
        TextButton(
            child: const CustomText(text: "Yes"),
            onPressed: () async {
              await LocalStorage.deleteLocalStorage('_user');
              await LocalStorage.deleteLocalStorage('_isWalkThrough');
              Future.delayed(const Duration(milliseconds: 500), () {
                BlocProvider.of<ProfileBloc>(context)
                    .add(SetProfileLogoutEvent());
                context.read<ProfileBloc>().add(SetProfileLogoutEvent());
              });
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName,
                  (route) => false,
                );
              });
            }),
        TextButton(
            child: const CustomText(text: "Close"),
            onPressed: () => Navigator.pop(context)),
      ],
    ).show(context);
  }
}
